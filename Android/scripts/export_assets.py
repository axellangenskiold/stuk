#!/usr/bin/env python3
"""Copy the current Xcode artwork verbatim and export its static Swift catalogues.

No Xcode project files or source images are changed. Network images are fetched
separately by download_images.py, so subsequent Android builds work offline.
"""
import json
import re
import shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / 'Android/app/src/main/assets/www'
OUT.mkdir(parents=True, exist_ok=True)
(OUT / 'images').mkdir(exist_ok=True)

def arguments(source, start):
    depth, quoted, escaped = 1, False, False
    for end in range(start, len(source)):
        c = source[end]
        if quoted:
            if escaped: escaped = False
            elif c == '\\': escaped = True
            elif c == '"': quoted = False
        elif c == '"': quoted = True
        elif c == '(': depth += 1
        elif c == ')':
            depth -= 1
            if depth == 0: return source[start:end], end
    raise ValueError('Unclosed Swift initializer')

def color(value):
    if 'Color.white' in value: return '#ffffff'
    if 'Color.clear' in value: return 'transparent'
    m = re.search(r'white:\s*([0-9.]+)', value)
    parts = [float(m[1])] * 3 if m else [float(v) for v in re.findall(r'(?:red|green|blue):\s*([0-9.]+)', value)]
    return '#' + ''.join(f'{round(v * 255):02x}' for v in parts) if len(parts) == 3 else '#212121'

def parse_entry(body):
    fields = {}
    # Field names occur only outside quoted strings / nested function arguments.
    positions = []
    quoted = escaped = False
    depth = 0
    for offset, token in enumerate(body):
        if quoted:
            if escaped: escaped = False
            elif token == '\\': escaped = True
            elif token == '"': quoted = False
        elif token == '"': quoted = True
        elif token in ('(', '['): depth += 1
        elif token in (')', ']'): depth -= 1
        elif depth == 0 and (offset == 0 or not body[offset-1].isalnum()):
            match = re.match(r'([a-zA-Z]+)\s*:', body[offset:])
            if match: positions.append((offset, offset + match.end(), match[1]))
    for i, (_, end, key) in enumerate(positions):
        value = body[end:positions[i+1][0] if i+1 < len(positions) else len(body)].strip().rstrip(',').strip()
        if value.startswith('"'): fields[key] = json.loads(value)
        elif value.startswith('pic'):
            seed = re.search(r'"([^"]+)"', value)[1]
            fields['seed'] = seed
            fields['image'] = f'images/remote-{seed}.jpg'
            fields['imageURL'] = f'https://picsum.photos/seed/{seed}/' + ('400/400' if value.startswith('picSquare') else '600/800')
        elif value.startswith('Color'): fields[key] = color(value)
        elif key == 'upcomingDates': fields[key] = re.findall(r'\("([^"]+)",\s*"([^"]+)"\)', value)
        elif value in ('true', 'false'): fields[key] = value == 'true'
    return fields

catalogues = {}
for filename, typename in [('DealItem.swift', 'DealItem'), ('EventItem.swift', 'EventItem'), ('TicketView.swift', 'CouponEntry')]:
    source = (ROOT / 'stuk' / filename).read_text()
    if typename == 'DealItem':
        for group in re.finditer(r'static let (\w+):\s*\[DealItem\]\s*=\s*\[', source):
            end = source.find('\n    ]', group.end())
            region = source[group.end():end]
            entries = []
            for entry in re.finditer(r'DealItem\(', region):
                body, _ = arguments(region, entry.end())
                entries.append(parse_entry(body))
            catalogues[group[1]] = entries
    else:
        entries = []
        for entry in re.finditer(typename + r'\(', source):
            body, _ = arguments(source, entry.end())
            entries.append(parse_entry(body))
        catalogues['events' if typename == 'EventItem' else 'coupons'] = entries

assets = {}
for folder in (ROOT / 'stuk/Assets.xcassets').glob('*'):
    if folder.suffix not in ('.imageset', '.appiconset'): continue
    info = json.loads((folder / 'Contents.json').read_text())
    files = [image['filename'] for image in info.get('images', []) if 'filename' in image]
    if not files: continue
    name = folder.stem
    src = folder / files[-1]
    dest = f'images/{name}{src.suffix.lower()}'
    shutil.copy2(src, OUT / dest)
    assets[name] = dest

catalogues['assets'] = assets
catalogues['cities'] = [{'name':name, 'seed':seed, 'image':f'images/remote-{seed}.jpg', 'imageURL':f'https://picsum.photos/seed/{seed}/600/800'} for name, seed in [('Stockholm','stockholm-skyline'),('Göteborg','goteborg-tram'),('Lund','lund-brickhouse'),('Malmö','malmo-square'),('Uppsala','uppsala-old')]]
catalogues['nearbyPromo'] = {'seed':'pressbyran-cafe-promo', 'image':'images/remote-pressbyran-cafe-promo.jpg', 'imageURL':'https://picsum.photos/seed/pressbyran-cafe-promo/600/800'}
for key, items in catalogues.items():
    for entry in (items if isinstance(items, list) else [items] if key == 'nearbyPromo' else []):
        if 'image' in entry: entry['imageAvailable'] = (OUT / entry['image']).exists()
(OUT / 'data.js').write_text('window.STUK_DATA = ' + json.dumps(catalogues, ensure_ascii=False, indent=2) + ';\n')
(ROOT / 'Android/scripts/image_manifest.json').write_text(json.dumps([entry for key, items in catalogues.items() for entry in (items if isinstance(items, list) else [items] if key == 'nearbyPromo' else []) if 'imageURL' in entry], ensure_ascii=False, indent=2))
print('Exported', len(assets), 'original assets;', {k:len(v) for k,v in catalogues.items() if isinstance(v, list)})
