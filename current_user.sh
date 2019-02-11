#!/bin/bash

function currentUser {
    currentUser=$( /usr/bin/last -1 -t console | awk '{print $1}' )
    echo $currentUser
}

currentUser