#!/bin/bash

myPassword='password'

function passSudoPassword {
	echo $1 | sudo -S ls /tmp
}

passSudoPassword $myPassword