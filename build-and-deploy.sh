#!/bin/bash
# MacsyZones Dev — build, sign, deploy and launch
set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_NAME="MacsyZones Dev"
SIGN_IDENTITY="MacsyZones Dev"
DERIVED_DATA="$HOME/Library/Developer/Xcode/DerivedData/MacsyZones-hjbwlhlonpyjtcgaywtqydihqzrh"

echo "Building..."
xcodebuild -project "$PROJECT_DIR/MacsyZones.xcodeproj" \
    -scheme MacsyZones \
    -configuration Debug \
    build \
    CODE_SIGN_IDENTITY="$SIGN_IDENTITY" \
    CODE_SIGN_STYLE=Manual \
    CODE_SIGNING_REQUIRED=YES \
    CODE_SIGNING_ALLOWED=YES \
    DEVELOPMENT_TEAM="" \
    2>&1 | grep -E "error:|BUILD"

echo "Stopping running instance..."
pkill -f "$APP_NAME" 2>/dev/null || true
sleep 1

echo "Deploying to /Applications..."
rm -rf "/Applications/$APP_NAME.app"
cp -R "$DERIVED_DATA/Build/Products/Debug/MacsyZones.app" "/Applications/$APP_NAME.app"

echo "Code signing..."
codesign --force --deep --sign "$SIGN_IDENTITY" "/Applications/$APP_NAME.app"

echo "Launching..."
open "/Applications/$APP_NAME.app"

echo "Done!"
