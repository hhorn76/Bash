#!/bin/bash
# This script will revoke admin rights for every user with an UniqueID greater than 500, therefore not touching hidden users or service accounts.
# Written by Heiko Horn - 2020.06.09

# Get a list of all users with an UniqueID above 500
ARRAY_USERS=$(dscl . list /Users UniqueID | awk '$2>500{print $1}' | grep -v support)

# Remove all local users  from the admin group using dseditgroup
for USER in ${ARRAY_USERS}; do
	echo "Removing user from local admin group: ${USER}"
	/usr/sbin/dseditgroup -o edit -d ${USER} admin
done

exit