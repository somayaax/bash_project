#!/bin/bash
cd ./databases/$1
PS3="$1 >>"

echo "Choose from the following"
COLUMNS=7
select choice in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table"
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
*) echo "Please enter from 1-7"
;;
esac
done

