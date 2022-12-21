#!/bin/bash
cd ./databases/$1

PS3="$1 >> "

echo "Choose from the following"
COLUMNS=8
select choice in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "back to main menu"
do
case $REPLY in 
1) ../../createTable.sh
;;
2) ls | grep -v .metadata$
;;
3) read -p "please enter table name" table
   while [ ! -f $table ] || [ ! $table ]
   do
	echo "Table not found" 
	read -p "please enter table name" table
   done
   rm $table 
   rm $table.metadata
;;
4) ../../insert.sh $1
;;
5) ../../select.sh $1
;;
6) ../../delete.sh
;;
7) ../../update.sh
;;
8) ../../mainmenu.sh
;;
esac
done

