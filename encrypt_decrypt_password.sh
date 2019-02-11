#!/bin/bash

# Function to encrypt password
encryptPw (){
	myPassword=$(echo $1 | base64)
	echo $myPassword
}

# Function to encrypt password
decryprPw () {
	echo $1 | base64 --decode 

}

encryptPw '8yaThaDCTGHxG8fu'
decryprPw $myPassword