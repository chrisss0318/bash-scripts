#!/bin/sh

#
# Check if Setup Assistant Process is Still Running.
# If yes, wait till it finishes so this script will NOT proceed while running the Setup Assistant (Location Settings..etc)
#

SetupAssistant_process=$(/bin/ps auxww | grep -q "[S]etup Assistant.app")
while [ $? -eq 0 ]
do
    /bin/echo "Setup Assistant Still Running... Sleep for 2 seconds..."
    /bin/sleep 2
    SetupAssistant_process=$(/bin/ps auxww | grep -q "[S]etup Assistant.app")
done

#.....
