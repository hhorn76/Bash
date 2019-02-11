#!/bin/bashf
# written by Heiko 11.02.2019

strPassword='8yaThaDCTGHxG8fu'

##########################################################
echo "Password: ${strPassword}"
echo ''

##########################################################
## Using base64
# Function to encrypt password
encryptPwBase64 (){
	strEncrypted=$(echo $1 | base64)
}

# Function to decrypt password
decryprPwBase64 () {
	strDecrypted=$(echo "${1}" | base64 --decode)
}

encryptPwBase64 ${strPassword}
echo "Base64 encrypted password: ${strEncrypted}"

decryprPwBase64 ${strEncrypted}
echo "Base64 decrypted password: ${strDecrypted}"
echo ''

##########################################################
## Using openssl
# Function to encrypt password
function encryptPwOpenSSL() {
	local strPassword="${1}"
	strSalt=$(openssl rand -hex 8)
	strPassphrase=$(openssl rand -hex 12)
	strEncrypted=$(echo "${strPassword}" | openssl enc -aes256 -a -A -S "${strSalt}" -k "${strPassphrase}")	
}
# Function to decrypt password
function decryptPwOpenSSL() {
	# Usage: ~$ DecryptString "Encrypted String" "Salt" "Passphrase"
	echo "${1}" | /usr/bin/openssl enc -aes256 -d -a -A -S "${2}" -k "${3}"
}

encryptPwOpenSSL ${strPassword}
echo "OpenSSL encrypted password: ${strEncrypted}"
echo "Salt: ${strSalt} | Passphrase: ${strPassphrase}"

strDecrypted=$(decryptPwOpenSSL "${strEncrypted}" "${strSalt}" "${strPassphrase}") 
echo "OpenSSL encrypted password: ${strDecrypted}"
