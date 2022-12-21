#!/bin/bash
cd ./databases/$1
let slashes=`pwd| tr -cd '/' | wc -c`
let curDB=${slashes}+1
PS3="`pwd | cut -d/ -f${curDB}` >> "

echo "Choose from the following"
COLUMNS=8
select choice in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "back to main menu"
do
case $REPLY in 
1) ../../createTable.sh
;;
2) ls | grep -v .metadata$
;;
3)echo "please enter table name"
   read table
   if [ -f $table ]
   then
   rm $table 
   rm $table.metadata
   else
   echo "table doesn't exist"
   fi
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

