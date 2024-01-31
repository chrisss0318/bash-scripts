#!/bin/bash
# 
# connetwiseversion.sh - For determining the local version of the Connectwise ScreenConnect agent.
# by Chris Hewinson

# Path to Applications directory
APP_DIR="/Applications"

# Check for any version of connectwise
APP_PATH=$(find "$APP_DIR" -name "connectwisecontrol*.app" -maxdepth 1)

# Determine if application is installed and get its version
if [ -n "$APP_PATH" ]; then
    #Extract version number from Info.plist
    VERSION=$(defaults read "${APP_PATH}/Contents/Info" CFBundleVersion)
    echo "<result>${VERSION}</result>"
else
    echo "<result>Not Installed</result>"
fi