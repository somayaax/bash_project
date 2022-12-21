
#!/bin/bash
function create {
read -p "Please enter database name: " name
while [[ $name = *" "* ]] || [ ! $name ] || [ -d ./databases/$name -a $name ]  || [[ ! $name =~ ^[a-zA-Z]*$ ]] 
	do
	
	if  [[ $name = *" "* ]]
	then
		echo "Name of database can't contain spaces!"
		read -p "Please enter database name: " name
	elif [ ! $name ] 
	then
		echo "You didn't enter database name"
		read -p "Please enter database name: " name

	elif [[ ! $name =~ ^[a-zA-Z]*$ ]]
	then
		echo "Name of database can't contain special characters or numbers!"
		read -p "Please enter database name: " name


	elif  [ -d ./databases/$name -a $name ] 
	then
		echo "Database already exist!"
		read -p "Please enter database name: " name
	fi
done

	mkdir -p ./databases/$name
	echo "database created successefuly"
}
COLUMNS=4
select x in 'create Database' 'list Databases' 'connect to Database' 'Drop Database'
do
case $REPLY in 
1) create
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

