#!/bin/bash
function create_Database {
	read -p "Please enter database name: " name
	while [ -d ./databases/$name ]
	do
		echo "Database already exist!"
		read -p "Please enter database name: " name
	done
	mkdir -p ./databases/$name
	echo database created successefuly
}

function check_Database {
	read -p "Please enter database name: " name
	while [ ! $name ]
	do
	echo "You didn't enter a database name"
	read -p "Please enter database name: " name
	done
	while [ ! -d ./databases/$name ]
	do
		echo "Database not found"
		read -p "Please enter database name: " name
	done
echo $name
}
COLUMNS=4
select x in 'create Database' 'list Databases' 'connect to Database' 'Drop Database'
do
case $REPLY in 
1) create_Database
;;
2) ls ./databases 
;;
3) 
   name=$(check_Database)
   gnome-terminal --title=$name -e "./secondaryMenu.sh $name" > /dev/null  
;;
4)
   name=$(check_Database)
   rm -r ./databases/$name
   echo "database dropped successfully"
;;
*) echo choose from 1-4
esac 
done

