#!/bin/bash
read -p "enter table name : " tableName
PS3="$tableName>>"

if [ -f $tableName -a $tableName ]
then

	select choice in "delete all without condition" "delete record with specific column"
	do
	case $REPLY in 
	#delete all records
	1) head -n 1 $tableName > temp
	   rm $tableName
	   mv temp $tableName
	;;
	2) read -p "enter condition : Column name >>  " column
           read -p "enter condition : Value  >>  " value
	   columnNumber=`grep -n -w $column $tableName.metadata | cut -d: -f1`
	   awk -v COL=$columnNumber -v VAL=$value -F ":" '{ if($COL!=VAL){print $0}}' $tableName > temp3
	   rm $tableName
	   mv temp3 $tableName
	;;
	esac 
	done
else 
echo "table doesn't exist"
fi

