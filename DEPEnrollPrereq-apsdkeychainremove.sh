#!/bin/sh
# DEPEnrollPrereq-apsdkeychainremove.sh
#
# For removing an expired APSD keychain from a Macbook and restarting the computer(Existing Device DEP Enroll prerequisite)
# Chris Hewinson/Monroe Smith - 7/17/2019
#

# Declare Certificate expiration variables
keychain="/Library/Keychains/apsd.keychain"
certexpiry=$(/usr/bin/security find-certificate -p -Z $keychain | /usr/bin/openssl x509 -checkend 600 | cut -f2 -d=)

# Run expiration check and delete expired certificate; prompts user and restarts computer if cert expired, prompts user if cert not expired
if [[ $certexpiry == "Certificate will expire" ]]; then
	echo "Certificate expired, deleting APSD keychain"
	rm -rf $keychain
	echo "Keychain removal complete, restarting computer"
    /Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -title "RESTART REQUIRED" -heading "Restart Required" -description "Maintence is complete, this computer requires a restart. Please save all of your work immediately and then click OK." -button1 "OK"
	shutdown -r +2
    exit 0
else
    echo "Certificate not expired yet, informing user and exiting."
    /Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -title "ERROR" -heading "Error: Certificate not expired" -description "Maintenance is not required on this computer, please contact IT Support if you believe this to be in error." -button1 "OK"
	exit 0
fi
