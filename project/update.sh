#!/bin/bash
function checkDataType {
ans=-1
if [[ $1 =~ ^[+-]?[0-9]+$ ]] && [[ $2 =~ int$ ]]; then
ans=1

elif [[ $1 =~ ^[a-zA-Z0-9]+$ ]]  && [[ $2 =~ string$ ]]; then
ans=1

elif [[ $1 =~ ^[+-]?[0-9]+\.?[0-9]*$ ]] && [[ $2 =~ float$ ]]; then
ans=1

else
ans=0
fi
return $ans
}
	
read -p "Please enter table name: " tableName
while [ -f $tableName -a $tableName ] 
do
	echo "Table already exist"
	read -p "Please enter table name: " tableName
done

	
	read -p "SET : Column name >>  " column 
	# check that the entered column is correct 
	columnExists=`cut -d: -f1 $tableName.metadata | grep -w $column`
	while [ ! $columnExists ]
	do
		echo "column doesn't exist in table $tableName"
		read -p "SET : Column name >>   " column 
		columnExists=`cut -d: -f1 $tableName.metadata | grep -w $column`
	done

	columnNumber=`grep -n -w $column $tableName.metadata | cut -d: -f1`
	read -p "SET  : $column value >>  " value
	dataType=` grep -w $column $tableName.metadata`
	checkDataType $value $dataType
	check=$?
	while [ $check = 0 ]
	do
		echo "data types doesn't match"
		read -p "SET  : $column value >>  " value
		checkDataType $value $dataType
		check=$?
	done

	read -p "enter condition : Column name >>  " columnCond
	columnCondExists=`cut -d: -f1 $tableName.metadata | grep -w $columnCond`

	while [ ! $columnCondExists ]
	do
		echo "column doesn't exist in table $tableName"
		read -p "enter condition : Column name >>  " columnCond
		columnCondExists=`cut -d: -f1 $tableName.metadata | grep -w $columnCond`
	done           		

	columnCondNumber=`grep -n -w $columnCond $tableName.metadata | cut -d: -f1`		

	read -p "enter condition : Value  >>  " valueCond
	
	#get number of rows to be updated
	numOfRows=`awk -v COLCOND=$columnCondNumber -v VALCOND=$valueCond -v COL=$columnNumber -v VAL=$value 'BEGIN{OFS=FS=":"}{ if($COLCOND==VALCOND){print $0}}' $tableName | wc -l`
	# if the user wants to update pk
	if [ $columnNumber == 1 ]
	then
		valueExists=`cut -d: -f1 $tableName| grep -w $value | wc -l`
		if [ $valueExists -gt 0 ]
		then		
			echo "value of primary key already exists"
			exit
		fi
		if [ $numOfRows -gt 1 ]
		then
			echo "can't set the same pk value for multiple rows"
			exit	
		fi
	fi
	
	if [ $numOfRows == 0 ]
	then
		echo "no match found"
	#perform update
	else
		awk -v COLCOND=$columnCondNumber -v VALCOND=$valueCond -v COL=$columnNumber -v VAL=$value 'BEGIN{OFS=FS=":"}{ if($COLCOND==VALCOND){$COL=VAL};print $0}' $tableName > temp
		mv temp $tableName
		echo " $numOfRows rows affected successfully"
	fi				


