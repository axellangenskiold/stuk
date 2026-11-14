#!/usr/bin/env python3
"""Serve only the finished APK to a phone on the same Wi-Fi network."""
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
import shutil
import subprocess
from urllib.parse import urlsplit

APK = Path(__file__).resolve().parents[1] / 'dist/STUK-Rurik-Hagman.apk'
PORT = 8765

class Download(BaseHTTPRequestHandler):
    def do_HEAD(self): self.download(False)
    def do_GET(self): self.download(True)
    def download(self, body):
        if urlsplit(self.path).path not in ('/', '/' + APK.name):
            self.send_error(404)
            return
        self.send_response(200)
        self.send_header('Content-Type', 'application/vnd.android.package-archive')
        self.send_header('Content-Disposition', f'attachment; filename="{APK.name}"')
        self.send_header('Content-Length', str(APK.stat().st_size))
        self.send_header('Cache-Control', 'no-store')
        self.end_headers()
        if body:
            with APK.open('rb') as source: shutil.copyfileobj(source, self.wfile)

if not APK.exists(): raise SystemExit('Build the APK with Android/build.sh first.')
address = subprocess.check_output(['ipconfig','getifaddr','en0'], text=True).strip()
server = ThreadingHTTPServer(('0.0.0.0', PORT), Download)
print(f'Phone download: http://{address}:{PORT}/{APK.name}', flush=True)
server.serve_forever()
