# !/bin/bash

# unlocks the "Time and Date" System Prefernces pane
security authorizationdb write system.preferences allow
security authorizationdb write system.preferences.datetime allow
