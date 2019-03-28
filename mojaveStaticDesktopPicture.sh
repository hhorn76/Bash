#!/bin/bash
# Written by Heiko Horn 2019.03.28

# Variables
currentUser=$( /usr/bin/stat -f%Su /dev/console )
db=/Users/${currentUser}/Library/Application\ Support/Dock/desktoppicture.db
if [ $4 ]; then 
	value="'$4'"
	image="$4"
else
	IMG=/Library/Desktop\ Pictures/MIS-2018.jpg
	value="'$IMG'"
	image="$IMG"
fi

# Exit if no databse file was found
if [ ! -f "$db" ]; then
	echo "ERROR: Did not find a valid database."
	exit 1
fi

# Close System Preferences – if open.
killall System\ Preferences > /dev/null 2>&1

# Delete all rows in the `data` and `preferences` tables.
sqlite3 "$db" "DELETE FROM data;"
sqlite3 "$db" "DELETE FROM preferences;"

# Insert a new row into the `data` and `preferences` tables.
sqlite3 "$db" "INSERT INTO data(rowid,value) VALUES( 1, $value );"
sqlite3 "$db" "INSERT INTO preferences(rowid,key,data_id,picture_id) VALUES(1,1,1,3);"
sqlite3 "$db" "INSERT INTO preferences(rowid,key,data_id,picture_id) VALUES(2,1,1,4);"
sqlite3 "$db" "INSERT INTO preferences(rowid,key,data_id,picture_id) VALUES(3,1,1,2);"
sqlite3 "$db" "INSERT INTO preferences(rowid,key,data_id,picture_id) VALUES(4,1,1,1);"
echo "The Desktop image has been set to $image."

# Restart the Dock so changes to desktoppicture.db take effect
killall Dock
