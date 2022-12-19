#!/bin/bash


read -p "enter table name : " tableName
PS3="$tableName>>"

if [ -f $tableName -a $tableName ]
then
	columns=`cut -d: -f1 $tableName.metadata`

	select choice in "delete all without condition" "delete a specific row " 
	do
	case $REPLY in 
	#delete all records
	1) head -n 1 $tableName > temp
	   rm $tableName
	   mv temp $tableName
	;;
	#delete a specific row
	2) read -p "enter id of the record you want to delete : " pk
		awk -v VARIABLE=$pk -F ":" '{ if ( $1 != VARIABLE ) print $0 }' $tableName  > temp2
		mv temp2 $tableName
	;;
	esac
	done
else 
echo "table doesn't exist"
fi
