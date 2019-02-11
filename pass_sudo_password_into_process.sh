#!/bin/bash
# written by Heiko 11.02.2019

myPassword='password'

function passSudoPassword {
	echo $1 | sudo -S ls /tmp
}

passSudoPassword $myPassword
