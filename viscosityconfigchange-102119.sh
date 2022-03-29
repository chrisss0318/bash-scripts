#!/bin/bash

##############
# viscosityconfigchange-102119.sh
##############
#
# For disabling the setting "Reconnect active connections on wake" in Viscosity
#
# Chris Hewinson - 10/21/19
#

# Define Variables
curUser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
curUserHome=(/users/"$curUser")
viscosityplist=("$curUserHome"/Library/Preferences/com.viscosityvpn.Viscosity.plist)

# Disables setting, changes file permissions back after root modifies, and restarts preferences cache
if [ -f "$viscosityplist" ]; then
    echo "Disabling Reconnect on Wake in $viscosityplist"
    defaults write "$viscosityplist" ReconnectOnWake -bool false
    chmod -R 0755 "$viscosityplist"
    killall cfprefsd
else
    echo "File does not exist, exiting.."
    exit 0
fi


# Check setting to confirm
echo "Confirming disabled.."
reconnectOnWake=$(/usr/libexec/PlistBuddy -c "Print :ReconnectOnWake" "$viscosityplist")
echo "value is $reconnectOnWake"
if [ "$reconnectOnWake" = "false" ]; then
   echo "Reconnect on Wake disabled"
 else
   echo "Error, please retry."
fi
