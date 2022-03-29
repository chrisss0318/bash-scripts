#!/bin/bash
#
# vpnconfigchange-101519.sh
#
# Extends OpenVPN handshake window from 10 to 30 seconds
# in Viscosity configs(for change from LUG to Duo for auth)
#
# Chris Hewinson - 10/15/2019
#

# VARIABLES
CurrentUser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
CurrentUserHome=(/Users/"$CurrentUser")


# Searches config files for hand-window value and changes from 10 to 30(seconds)
echo "Changing OpenVPN handshake window.."
sed -i -e '/hand-window 10/ s/10/30/' $CurrentUserHome/Library/Application\ Support/Viscosity/OpenVPN/1/config.conf
sed -i -e '/hand-window 10/ s/10/30/' $CurrentUserHome/Library/Application\ Support/Viscosity/OpenVPN/2/config.conf

# Confirms proper changes have been made
if  grep -rq "^hand-window 30" $CurrentUserHome/Library/Application\ Support/Viscosity/OpenVPN; then
  echo "Change Complete"
else
  echo "ERROR"
fi

exit 0
