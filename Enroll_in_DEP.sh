#!/bin/bash
#
# Enroll_in_DEP.sh
#
# For enrolling existing devices into DEP
# 2019 - Monroe Smith/Chris Hewinson
#
# ---------------- #
# Variable(s)
# ---------------- #
enroll_status=$(profiles status -type enrollment | grep "Enrolled via DEP:")

# ---------------- #
# Define functions #
# ---------------- #

# Check device enrollment. If already enrolled then exit program. If not enrolled then proceed.
function check_enrollment {
	echo "Status: Checking device enrollment"
	if [[ $enroll_status == "Enrolled via DEP: Yes" ]]; then
		echo "Device enrolled: Yes"
		/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -title "ALREADY DEP ENROLLED" -heading "ALREADY DEP ENROLLED" -description "This computer is already enrolled in DEP." -button1 "OK"
		echo "Status: Exiting"
		exit 0
	else
		echo "Device enrolled: No"
		enroll_in_dep
	fi
}


# Run command to enroll device in DEP. Sleep for 30 sec to give user time to complete the enrollment steps before verifying.
function enroll_in_dep {
	echo "Status: Initiating device enrollment"
    echo "Status: Triggering tempadmin policy"
    jamf policy -trigger tempadmin
    echo "Status: Sleeping for 30 seconds"
    sleep 30
    echo "Status: Enrolling device in DEP"
	  profiles renew -type enrollment
		while [[ $enroll_status = "Enrolled via DEP: No" ]]; do
			sleep 1
			enroll_status=$(profiles status -type enrollment | grep "Enrolled via DEP:")
		done
    if [[ $enroll_status = "Enrolled via DEP: Yes" ]]; then
			verify_enrollment
		fi
}

# Verify if enrollment was successful. Inform user if it has succeeded or failed, then exit program.
function verify_enrollment {
	enroll_status=$(profiles status -type enrollment | grep "Enrolled via DEP:")
	echo "Status: Verifying enrollment"
	if [[ $enroll_status == "Enrolled via DEP: Yes" ]]; then
		echo "Device enrollment: Successful"
		/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -title "ENROLLMENT COMPLETE" -heading "Enrollment Complete" -description "Successfully enrolled in DEP!" -button1 "OK"
	else
		echo "Device enrollment: Unsuccessful"
		/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -title "ENROLLMENT FAILED" -heading "Enrollment Failed" -description "There was an error enrolling this computer in DEP. Please reach out to IT in FreshService for assistance." -button1 "OK"
	fi
	echo "Status: Finished"
	exit 0
}

# ---------------- #
# Start the script #
# ---------------- #
check_enrollment
