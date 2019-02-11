#!/bin/bashf
# written by Heiko 11.02.2019

strPassword='8yaThaDCTGHxG8fu'

# Function to encrypt password
encryptPw (){
	myEncryptedPassword=$(echo $1 | base64)
}

# Function to encrypt password
decryprPw () {
	myDecryptedPassword=$(echo "${1}" | base64 --decode)
}

encryptPw '8yaThaDCTGHxG8fu'
echo "My Encrypted Password is: $myEncryptedPassword"

decryprPw $myEncryptedPassword
echo "My Decrypted Password is: $myDecryptedPassword"