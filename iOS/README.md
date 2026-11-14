# STUK iOS installation

`STUK-Axel.ipa` packages the verified native SwiftUI device build installed on 12 November 2026. The source files and artwork were checked against that build before packaging. It is an iPhone device build, not a simulator build. SHA-256 is in `SHA256.txt`.

The iOS profile defaults to **Axel Langenskiöld**, `axel@langenskiold.se`, initials `AL`, and the existing Axel personal number in `Shared.swift`. The app applies this configuration at startup, and the selected card images contain Axel's details directly. The Android APK is a separate build configured for Rurik Hagman.

## Xcode

1. Connect and unlock the iPhone.
2. Open `../stuk.xcodeproj`, select scheme `stuk`, and select the connected iPhone as the run destination.
3. Under target `stuk` → Signing & Capabilities, use automatic signing and Axel's team (`7WN3ACZRL9`). This matches the app already installed on Axel's iPhone.
4. Press Command-R to build, install, and launch.

See [Apple's device-run guide](https://developer.apple.com/documentation/xcode/running-your-app-on-simulated-or-physical-devices).

## AltServer on Mac

1. Open AltServer, connect the iPhone by USB, and unlock it.
2. Hold Option while clicking the AltServer menu-bar icon.
3. Choose **Sideload .ipa…**, select the iPhone if prompted, and select `STUK-Axel.ipa`.
4. Enter your Apple Account details into AltServer when prompted and approve the device trust prompts if requested.

AltServer re-signs the IPA for the selected account/device. The account used for signing does not change the fixed Axel profile or the image contents. Signing with a different team from an existing installation may prevent an in-place update.

See [AltServer's direct IPA sideloading instructions](https://faq.altstore.io/release-notes/altserver).

## Refreshing

With a free Apple Personal Team, provisioning lasts seven days. Xcode installations can be renewed by rebuilding and running again. Direct AltServer installations require re-sideloading; AltStore Classic plus AltServer supports background/manual app refreshes. AltServer must be reachable over USB or the same Wi-Fi for the standard local refresh workflow.

The provisioning embedded in the original 12 November build expires **19 November 2026 at 22:35 UTC**. AltServer replaces this provisioning when it re-signs for installation.

Sources: [Apple Personal Team limits](https://developer.apple.com/help/account/basics/about-your-developer-account), [AltStore refreshing](https://faq.altstore.io/altstore-classic/your-altstore), [AltServer connection requirements](https://faq.altstore.io/altstore-classic/altserver).
