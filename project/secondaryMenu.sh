#!/bin/bash
cd ./databases/$1

PS3="$1 >> "

echo "Choose from the following"
COLUMNS=8
select choice in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table"
do
case $REPLY in 
1) ../../createTable.sh
;;
2)
	tables=`ls | grep -v .metadata$ | wc -l` 
	if [ $tables -gt 0 ]
	then
		echo ""
		echo `ls | grep -v .metadata$ `
		echo ""		
	else
		echo -e "\nno tables to show\n"
	fi	
;;
3) read -p "please enter table name: " table

while [ ! -f $table ] || [ ! $table ]
do
	if [ ! $table ]
	then
	echo -e "\nYou didn't enter a table name\n"
	else
	echo -e "\nTable not found\n"
	fi
	read -p "Please enter table name: " table
done
   rm $table 
   rm $table.metadata
   echo -e "\ntable $table dropped successfully\n"
;;
4) ../../insert.sh $1
;;
5) ../../select.sh $1
;;
6) ../../delete.sh
;;
7) ../../update.sh
;;
*) echo -e "\nenter num from 1-7 only\n"
;;
esac
done
