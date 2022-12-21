#!/bin/bash
echo -e "\n DELETE \n"
	read -p "Please enter table name: " tableName

while [ ! -f $tableName -a $tableName ] 
do
	echo "Table doesn't exist"
	read -p "Please enter table name: " tableName
done

PS3="Delete FROM $tableName>>"
select choice in "Delete all records without condition" "Delete record with specific column"
do
case $REPLY in 
#delete all records
1) head -n 1 $tableName > temp
   rm $tableName
   mv temp $tableName
   echo " deleted successfully"
;;
2) read -p "enter condition : Column name >>  " column
   read -p "enter condition : Value  >>  " value
	while [ ! $column ]  || [ ! $value ] 
        do
	echo "Fields can't be empty!"
	read -p "enter condition : Column name >>  " column
        read -p "enter condition : Value  >>  " value
	done
   columnNumber=`grep -n -w $column $tableName.metadata | cut -d: -f1`
   awk -v COL=$columnNumber -v VAL=$value -F ":" '{ if($COL!=VAL){print $0}}' $tableName > temp3
if `cmp $tableName temp3` >/dev/null 2> /dev/null
then 
echo "No records found with this condition"
else
   rm $tableName
   mv temp3 $tableName
   echo "Deleted successfully"
fi 

;;
*) echo "please enter value 1 or 2"
;;
esac 
done


