#!/bin/sh
set -eu
cd "$(dirname "$0")"
if [ -z "${JAVA_HOME:-}" ]; then
  if [ -x /usr/libexec/java_home ]; then JAVA_HOME=$(/usr/libexec/java_home -v 17); export JAVA_HOME; fi
fi
export GRADLE_USER_HOME="$PWD/.gradle-home"
if [ -d "$PWD/.toolchain/sdk" ]; then export ANDROID_HOME="$PWD/.toolchain/sdk"; fi
mkdir -p .signing
if [ ! -f .signing/stuk-release.jks ]; then
  "${JAVA_HOME:+$JAVA_HOME/bin/}keytool" -genkeypair -keystore .signing/stuk-release.jks -storepass stuk-local-build -keypass stuk-local-build -alias stuk -dname 'CN=STUK Local Android, OU=Personal Build' -keyalg RSA -keysize 2048 -validity 10000
fi
./gradlew --no-daemon :app:assembleRelease :app:lintRelease "$@"
mkdir -p dist
cp app/build/outputs/apk/release/app-release.apk dist/STUK-Rurik-Hagman.apk
shasum -a 256 dist/STUK-Rurik-Hagman.apk > dist/SHA256.txt
printf '\nAPK: %s/dist/STUK-Rurik-Hagman.apk\n' "$PWD"
