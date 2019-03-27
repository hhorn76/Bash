#!/bin/bash
# written by Heiko 11.02.2019

function currentUserLast {
    currentUser=$( /usr/bin/last -1 -t console | awk '{print $1}' )
    echo $currentUser
}

function currentUserWho {
    currentUser=$( /usr/bin/who | grep 'console' | awk '{print $1}' )
    echo $currentUser
}

function currentUserLs {
    currentUser=$( /bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }' )
    echo $currentUser
}

function currentUserStat {
    currentUser=$( /usr/bin/stat -f%Su /dev/console )
    echo $currentUser
}

function currentUserDefaults {
    currentUser=$( /usr/bin/defaults read /Library/Preferences/com.apple.loginwindow.plist lastUserName )
    echo $currentUser
}

function currentUserPythonSysConfig {
    currentUser=$( /usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");' )
    echo $currentUser
}

currentUserLast
currentUserWho
currentUserLs
currentUserStat
currentUserDefaults
currentUserPythonSysConfig
