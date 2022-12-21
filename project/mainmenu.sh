
#!/bin/bash
function create_Database {
	read -p "Please enter database name: " name
	
nameEmpty=1
regexProblem=1
databaseExist=1
while [ $nameEmpty == "1" ] || [ $regexProblem == "1" ] || [ $databaseExist == "1" ]
do 
	while [ ! $name ]
	do
	echo "You didn't enter database name"
	read -p "Please enter database name: " name
	nameEmpty=1
	done
	nameEmpty=0
	while [[ ! "${name}" =~ ^[a-zA-Z]*$ ]] || [[ $name = ^[\ ]*$ ]];  
	do
	echo "Name of database can't contain special characters or spaces"
	read -p "Please enter database name: " name
	regexProblem=1
	done
	regexProblem=0
	while [ -d ./databases/$name -a $name ] 
	do
		echo "Database already exist!"
		read -p "Please enter database name: " name
		databaseExist=1
	done
	databaseExist=0


done


	mkdir -p ./databases/$name
	echo database created successefuly




}

COLUMNS=4
select x in 'create Database' 'list Databases' 'connect to Database' 'Drop Database'
do
case $REPLY in 
1) create_Database
;;
2) 
	if [ -e ./databases ] 
	then 
		ls ./databases
	else
		echo -e "\nNo Databases found!\n"
	fi
	 
;;
3) 
   	read -p "Please enter database name: " name
	while [ ! -d ./databases/$name ] || [ ! $name ]
	do
		if [ ! -d ./databases/$name ]
		then
			echo -e "\nDatabase not found\n"
		else
			echo -e "\nYou didn't enter a database name\n"
		fi
		read -p "Please enter database name: " name
	done
	gnome-terminal --title=$name -e "./secondaryMenu.sh $name" > /dev/null  
;;
4)
   	read -p "Please enter database name: " name
	while [ ! -d ./databases/$name ] || [ ! $name ]
	do
		if [ ! -d ./databases/$name ]
		then
		echo -e "\nDatabase not found\n"
		else
		echo -e "\nYou didn't enter a database name\n"
		fi
		read -p "Please enter database name: " name
	done
   rm -r ./databases/$name
   echo "database dropped successfully"
;;
*) echo choose from 1-4
esac 
done

