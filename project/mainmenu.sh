#!/bin/bash

COLUMNS=4
select x in 'create Database' 'list Databases' 'connect to Database' 'Drop Database'
do
case $REPLY in 
1) echo enter database name: 

	read name	
	if [ -d ./databases/$name ]
	then 

	echo database already exists
	else
	mkdir -p ./databases/$name
	echo database created successefuly
	fi
;;
2) ls ./databases 
;;
3) echo enter database name: 
	read name
	if [ -d ./databases/$name ]
	then 
	gnome-terminal --title=newWindow -e "./secondaryMenu.sh $name" > /dev/null       
	else
	echo "database doesn't exist"
	fi
;;
4) echo enter database name:
	read name
	if [ -d ./databases/$name ]
	then
	rm -r ./databases/$name
	echo "database dropped successfully"
	else
	echo "database doesn't exist"
	fi 
;;
*) echo choose from 1-4
esac 
done
