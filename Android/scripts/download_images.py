#!/usr/bin/env python3
"""Cache the exact remote image URLs used by SwiftUI in the installable APK."""
import concurrent.futures
import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'app/src/main/assets/www'
entries = json.loads((ROOT / 'scripts/image_manifest.json').read_text())
entries = list({entry['seed']:entry for entry in entries}.values())

def download(entry):
    dest = OUT / entry['image']
    if dest.exists() and dest.stat().st_size > 1000: return
    subprocess.run(['curl','-fsSL','--retry','3','--max-time','90',entry['imageURL'],'-o',str(dest)], check=True)

with concurrent.futures.ThreadPoolExecutor(max_workers=6) as pool:
    list(pool.map(download, entries))
print(f'Cached {len(entries)} source images.')
