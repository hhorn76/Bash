#!/bin/bash
# written by Heiko 11.02.2019

function currentUser {
    currentUser=$( /usr/bin/last -1 -t console | awk '{print $1}' )
    echo $currentUser
}

currentUser