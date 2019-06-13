#!/bin/bash

### get creation date of file using stat
function getFileCreationDateStat {
	strDate=$(/usr/bin/stat -f "%B" "${1}")
	/bin/date -j -u -f "%s" $strDate +'%Y-%m-%d'
}

### get creation date of file using mdsl
function getFileCreationDateMdsl {
	/usr/bin/mdls "${1}" | grep kMDItemFSCreationDate | awk '{print $3}'
}

FILE=~/Desktop/API\ Login.txt

getFileCreationDateMdsl "${FILE}"
strDate=$(getFileCreationDateStat "${FILE}")