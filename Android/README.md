# STUK for Android

The installable file is [`dist/STUK-Rurik-Hagman.apk`](dist/STUK-Rurik-Hagman.apk). It is a signed, universal APK (11.4 MB) for Android 9 and later, including the Samsung Galaxy S22. It installs directly without Android Studio, a companion app, or a separate asset download.

## Install on the S22

1. Transfer the APK to the phone, or run `python3 scripts/share_apk.py` on this Mac and open the printed address on a phone connected to the same Wi-Fi. Keep the Mac awake while downloading. The download server exposes only this APK.
2. Open the downloaded APK in the phone's Downloads folder.
3. If prompted, allow installation from the browser or file manager being used, then tap **Install**.
4. Open **STUK**.

The current temporary Wi-Fi address is `http://172.20.10.7:8765/STUK-Rurik-Hagman.apk`. It can change when the Mac changes networks. This is a local network link, not public hosting. If this address stops responding, restart the sharing script and use its new address.

## Implementation and scope

This is a standalone Android project. It does not belong to the Xcode project and does not change any Swift source or original artwork.

The Android activity is Java; the recreated interface is bundled HTML/CSS/JavaScript rendered in Android WebView. This is **not a Swift-to-Kotlin rewrite**. All five tabs, the original static catalogues, detail pages, category drawer, calendar/sort sheets, nearby cities, coupon sheets, and card interactions are implemented. The reference layout uses a 390-point canvas scaled to the phone's width, with real Android status/navigation insets.

The account is fixed in `app/src/main/assets/www/app.js`:

- Name: Rurik Hagman
- Email: rurik.hagman@gmail.com
- Personal number: 0105013338

All 50 repository image assets were copied byte for byte; see `verification/asset-integrity.json`. Original card dates, static coupon/event dates, and printed image contents are retained. The app has no network permission and does not connect to Firebase or authenticate membership. Buttons with empty actions in the SwiftUI source retain those empty actions here.

**Visual limitations:** a pixel-for-pixel match has not been established against an iPhone screenshot or a physical Samsung S22. Android font rendering and the recreated SVG symbols differ from Apple's system fonts/symbols. The original Picsum image service returned HTTP 522/timeouts during the build, so remote deal/event/city photos could not be cached. Those areas use the source app's brand/color fallback treatment; all repository images, including the card artwork, QR screen and loading screen, are bundled.

## Build

Use JDK 17 or 21 and an Android SDK with platform 35/build tools 34.0.0. On the machine used for this build the SDK lives in the ignored `.toolchain/sdk` directory.

```sh
cd Android
./build.sh
```

The script runs the release build and Android lint, creates `dist/STUK-Rurik-Hagman.apk`, and writes `dist/SHA256.txt`. Gradle and the Android Gradle plugin are pinned in the project. Their compatibility follows the [Android Gradle plugin 8.7 documentation](https://developer.android.com/build/releases/agp-8-7-0-release-notes).

Release signing uses `.signing/stuk-release.jks`. Preserve this ignored file to issue compatible updates to an installed copy. The local build script generates it on first use. Package ID: `se.stuk.rurik`; version: `1.0` (1). The APK has no native architecture-specific libraries and is not debuggable.

To refresh the artwork/catalogues from this repository, then retry the original remote photos when their service recovers:

```sh
python3 scripts/export_assets.py
python3 scripts/download_images.py
python3 scripts/export_assets.py
./build.sh
```

## Verification

The signed release APK was verified with `apksigner`, installed, and launched in an Android 15 ARM64 emulator at 1080 × 2340, density 440. A debug build of the same activity and bundled interface passed 33 end-to-end checks, including a physical emulator swipe, Android Back handling, fixed profile fields, every navigation tab, category/search flows, coupon/date sheets, all three cards, QR, and the two-second refresh. No JavaScript runtime exceptions were recorded.

Results are in `verification/smoke-test.json`; screenshots are in `verification/screenshots`. The final release startup is recorded in `verification/release-install.txt`. Android lint completed with zero errors; remaining warnings concern the intentional portrait orientation, legacy square launcher icon, and backup configuration.

To rerun the UI checks with a running emulator at `emulator-5554` and Python's `websocket-client` package installed:

```sh
./build.sh :app:assembleDebug
python3 scripts/smoke_test.py
```
