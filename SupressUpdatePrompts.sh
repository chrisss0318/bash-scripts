#!/bin/sh
#
#
# For hiding update prompts, it looks for any notifications in the app store webkit. If it sees them, it removes them immediately.
# If none are found, it overwrites them with a blank copy(thus still showing nothing)
#
##
if [ -e ~/Library/Containers/com.apple.appstore/Data/Library/WebKit/LocalStorage/https_su.itunes.apple.com_0.localstorage ]
    then
        rm -rf ~/Library/Containers/com.apple.appstore/Data/Library/WebKit/LocalStorage/https_su.itunes.apple.com_0.localstorage
        cp -R /usr/local/outset/custom/https_su.itunes.apple.com_0.localstorage ~/Library/Containers/com.apple.appstore/Data/Library/WebKit/LocalStorage/
    else
        mkdir -p ~/Library/Containers/com.apple.appstore/Data/Library/WebKit/LocalStorage
        cp -R /usr/local/outset/custom/https_su.itunes.apple.com_0.localstorage ~/Library/Containers/com.apple.appstore/Data/Library/WebKit/LocalStorage/
fi
