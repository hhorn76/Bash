#!/bin/bash

# Initialize an array to store user logons
ArrayName=()

# Get the current username
currentUser=$( /usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");' )

# Function using syslog to fill array with users that have already logged on to device
function getSyslog {
	for USER in $(/usr/bin/sudo -u root /usr/bin/syslog -F raw -k Facility com.apple.system.lastlog | /usr/bin/awk '{ print substr($28,1,length($28)-1) }' | /usr/bin/grep ${currentUser}); do
		ArrayName+=( ${USER} )
	done
}
# Function using last to fill array with users that have already logged on to device
function getConsole {
	for USER in $(/usr/bin/last -t console | /usr/bin/awk '{ print $1 }' | /usr/bin/grep ${currentUser}); do
		ArrayName+=( ${USER} )
	done
}
# Function to evalute the first login
function getLogins {
	if [[ "${#ArrayName[@]}" < "2" ]]; then
		echo 'User has logged on for the first time...'
		# Call a trigger if user has logged on for the first time
		/usr/local/bin/jamf policy -event userEnvironment
	else 
		echo "Known user...( ${#ArrayName[@]} logins )"
	fi
}

#Call the syslog function
getSyslog
getLogins
getConsole
getLogins
