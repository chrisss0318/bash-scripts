#!/bin/bash
# 
# isconnectwiseinstalled.sh - If Connectwise ScreenConnect is installed, display a result(ex: for MDM extension attribute) of installed
# by Chris Hewinson
#
# Path to Applications directory
APP_DIR="/Applications"

# Check for any version of connectwise
APP_FOUND=$(find "$APP_DIR" -name "connectwisecontrol*.app" -maxdepth 1)

# Determine if application is installed
if [ -n "$APP_FOUND" ]; then
    echo "<result>installed</result>"
else
    echo "<result>not installed</result>"
fi
