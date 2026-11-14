#!/usr/bin/env python3
"""Run UI checks against a real Android WebView in the S22-sized emulator.

Requires a running emulator and Python's websocket-client package. The debug
APK uses the same assets, activity and layouts as the signed release APK.
"""
import json
import subprocess
import time
import urllib.request
from pathlib import Path
import websocket

ROOT = Path(__file__).resolve().parents[1]
ADB = str(ROOT / '.toolchain/sdk/platform-tools/adb')
REPORT = ROOT / 'verification'
REPORT.mkdir(exist_ok=True)
(REPORT / 'screenshots').mkdir(exist_ok=True)
checks = []

def adb(*args):
    return subprocess.check_output([ADB, '-s', 'emulator-5554', *args])

adb('install', '-r', str(ROOT / 'app/build/outputs/apk/debug/app-debug.apk'))
adb('shell', 'am', 'force-stop', 'se.stuk.rurik.debug')
adb('shell', 'am', 'start', '-n', 'se.stuk.rurik.debug/se.stuk.rurik.MainActivity')
for _ in range(60):
    try:
        pid = adb('shell', 'pidof', 'se.stuk.rurik.debug').decode().strip()
        adb('forward', 'tcp:9222', f'localabstract:webview_devtools_remote_{pid}')
        pages = json.load(urllib.request.urlopen('http://127.0.0.1:9222/json', timeout=2))
        if pages: break
    except Exception: pass
    time.sleep(.5)
else: raise RuntimeError('Android WebView did not start')

ws = websocket.create_connection(pages[0]['webSocketDebuggerUrl'], suppress_origin=True, timeout=15)
sequence = 0
exceptions = []
def cdp(method, params=None):
    global sequence
    sequence += 1
    ws.send(json.dumps({'id':sequence, 'method':method, 'params':params or {}}))
    while True:
        reply = json.loads(ws.recv())
        if reply.get('method') == 'Runtime.exceptionThrown': exceptions.append(reply['params'])
        if reply.get('id') == sequence:
            if 'error' in reply: raise RuntimeError(reply['error'])
            return reply.get('result', {})

def js(expression):
    result = cdp('Runtime.evaluate', {'expression':expression, 'returnByValue':True, 'awaitPromise':True})
    if 'exceptionDetails' in result: raise AssertionError(result['exceptionDetails'])
    return result.get('result', {}).get('value')

def check(name, expression):
    result = js(expression)
    assert result, f'{name}: {result!r}'
    checks.append(name)
    print('PASS', name, flush=True)

def click(selector):
    assert js(f'!!document.querySelector({json.dumps(selector)})'), selector
    js(f'document.querySelector({json.dumps(selector)}).click()')
    time.sleep(.12)

def tab(name): click(f'#tabs [data-value="{name}"]')
def screenshot(name):
    time.sleep(.35)
    (REPORT / 'screenshots' / f'{name}.png').write_bytes(adb('exec-out','screencap','-p'))

cdp('Runtime.enable')
for _ in range(30):
    if js('!!window.appBack'): break
    time.sleep(.2)

check('Home starts offline with five navigation tabs', 'route.name === "home" && document.querySelectorAll(".tab").length === 5')
check('S22 layout uses the 390 point reference canvas without horizontal overflow', 'innerWidth===390 && screen.scrollWidth===screen.clientWidth')
time.sleep(1.5) # Wait for the first Android surface composition after the cold launch.
screenshot('home')
tab('profile')
check('Profile uses the requested fixed name and email', 'screen.textContent.includes(ACCOUNT.name) && screen.textContent.includes(ACCOUNT.email)')
screenshot('profile')
click('[data-action="settings"]')
check('Identity fields contain the exact requested values and are read only', 'document.querySelector("#fixed-person").value === "0105013338" && [...document.querySelectorAll("input")].every(input=>input.readOnly)')
screenshot('settings')
adb('shell','input','keyevent','4');time.sleep(.25)
check('Android Back returns from settings to profile', 'route.name==="profile"')
tab('calendar')
check('Every original event is available', 'document.querySelectorAll(".event").length === 11')
screenshot('events')
click('[data-action="calendar-modal"]')
click('[data-action="day"][data-value="15"]')
check('Calendar selection updates', 'selectedDay===15')
click('[data-action="clear-day"]')
check('Calendar selection clears', 'selectedDay===null')
adb('shell','input','keyevent','4');time.sleep(.2)
click('[data-action="sort"]')
click('[data-action="sort-choice"][data-value="1"]')
check('Sort sheet updates its selection', 'sortChoice===1 && !!document.querySelector(".radio.selected")')
screenshot('sort')
click('.sheet [data-action="dismiss"]')
click('[data-action="event"][data-value="0"]')
check('Event detail contains original description and future dates', 'screen.textContent.includes(D.events[0].description) && document.querySelectorAll(".date-option").length === 3')
click('[data-action="event-date"][data-value="1"]')
check('Event date selection works', 'eventDate===1')
screenshot('event-detail')
tab('tickets')
check('All original coupons appear', 'document.querySelectorAll(".coupon").length===15')
screenshot('coupons')
click('[data-action="coupon"][data-value="0"]')
check('Coupon sheet opens with the original description', 'modal.name==="coupon" && overlay.textContent.includes(D.coupons[0].description)')
screenshot('coupon-sheet')
click('.close-row [data-action="dismiss"]')
check('Coupon sheet dismisses', '!modal && !overlay.children.length')
tab('home')
click('[data-action="menu"]')
check('All original categories appear', 'document.querySelectorAll(".category").length===14')
screenshot('categories')
click('[data-action="list"][data-value="Kläder & Mode"]')
check('Category filters the deal grid', 'route.category==="Kläder & Mode" && document.querySelectorAll(".deal").length>0')
click('.deal')
check('Deal page renders original terms and description', '!!document.querySelector(".terms") && !!document.querySelector(".detail-description")')
click('#favorite')
check('Saving a deal updates its control', 'document.querySelector("#favorite").getAttribute("aria-pressed")==="true"')
click('#favorite')
screenshot('deal-detail')
tab('home')
js('document.querySelector("#home-search").value="Samsung";document.querySelector("#home-search").dispatchEvent(new KeyboardEvent("keydown",{key:"Enter",bubbles:true}))')
check('Search returns matching original deals', 'route.query==="Samsung" && document.querySelectorAll(".deal").length>0 && [...document.querySelectorAll(".photo-label")].every(node=>node.textContent==="SAMSUNG")')
tab('home')
click('[data-action="nearby"]')
check('Nearby lists the five original cities', 'document.querySelectorAll(".city").length===5')
screenshot('nearby')
click('[data-action="city"][data-value="2"]')
check('City page opens', 'route.name==="city" && screen.textContent.includes("Lund")')
tab('card')
check('Card opens with original artwork', 'cardIndex===1 && document.querySelector(".card-face.front img").complete && document.querySelector(".card-face.front img").naturalWidth>0')
screenshot('card-1-front')
click('.card-stage')
check('Card flips and uses the fixed identity', 'cardFlipped && document.querySelector(".card-person").textContent.includes("Rurik Hagman") && document.querySelector(".card-person").textContent.includes("0105013338")')
screenshot('card-1-back')
click('[data-action="card-select"][data-value="2"]')
check('Second card selects correctly and preserves its face', 'cardIndex===2 && cardFlipped && document.querySelector(".card-person").classList.contains("nation")')
screenshot('card-2-back')
click('[data-action="card-select"][data-value="3"]')
check('Third card selects correctly', 'cardIndex===3 && document.querySelector(".card-person").classList.contains("studentlund")')
screenshot('card-3-back')
click('[data-action="card-select"][data-value="1"]')
# Physical swipe across the actual emulator surface, not a call to the app handler.
adb('shell','input','swipe','850','1100','200','1100','250');time.sleep(.3)
check('Physical swipe selects the next card', 'cardIndex===2')
click('[data-action="qr"]')
check('QR overlay uses the original bundled image', 'modal.name==="qr" && document.querySelector(".qr-card").naturalWidth>0')
screenshot('qr')
adb('shell','input','keyevent','4');time.sleep(.2)
check('Android Back dismisses QR without leaving the card', '!modal && route.name==="card"')
click('[data-action="refresh"]')
check('Refresh displays original loading art', 'modal.name==="loading" && !!document.querySelector(".loading-card")')
time.sleep(2.2)
check('Refresh returns after two seconds', '!modal && route.name==="card"')
click('[data-action="close-card"]')
check('Closing the card returns home', 'route.name==="home"')
check('Every bundled image on the screen decodes', '[...document.images].every(img=>img.complete && img.naturalWidth>0)')
assert not exceptions, exceptions
checks.append('No JavaScript runtime exceptions during all navigation')
report = {'device':adb('shell','wm','size').decode().strip(), 'density':adb('shell','wm','density').decode().strip(), 'android':adb('shell','getprop','ro.build.version.release').decode().strip(), 'checks':checks, 'count':len(checks), 'runtimeExceptions':exceptions, 'layout':js('({width:innerWidth,height:innerHeight,dpr:devicePixelRatio})')}
(REPORT / 'smoke-test.json').write_text(json.dumps(report,indent=2)+'\n')
print(f'{len(checks)} checks passed.',flush=True)
ws.close()
