#!/bin/bash
IFS=Z$'\n'
arrList=$(cat << EOF
0,test0,TEST0
1,test1,TEST1
2,test2,TEST2
3,test3,TEST3
4,test4,TEST4
5,test5,TEST5
EOF
)

for items in ${arrList[@]}; do
	IFS=$',' read -r id name desc <<< "$items"
	echo "ID: ${id}"
	echo "Name: ${name}"
	echo "Description: ${desc}"
	echo ''
done