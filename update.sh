printf "enter table name: "
read tableName

if [ -f $tableName -a $tableName ]
then
	read -p "set [ enter column name ] : " column 
	
	columnExists=`cut -d: -f1 $tableName.metadata | grep -w $column`
	while [ ! $columnExists ]
	do
		echo "column doesn't exist in table $tableName"
		read -p "set [ enter column name ] : " column 
		columnExists=`cut -d: -f1 $tableName.metadata | grep -w $column`
	done

	columnNumber=`grep -n -w $column $tableName.metadata | cut -d: -f1`
	read -p "$column [ enter value ] = " value
		#check data type for this value ^

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

	numOfRows=`awk -v COLCOND=$columnCondNumber -v VALCOND=$valueCond -v COL=$columnNumber -v VAL=$value 'BEGIN{OFS=FS=":"}{ if($COLCOND==VALCOND){print $0}}' $tableName | wc -l`
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
	else
		awk -v COLCOND=$columnCondNumber -v VALCOND=$valueCond -v COL=$columnNumber -v VAL=$value 'BEGIN{OFS=FS=":"}{ if($COLCOND==VALCOND){$COL=VAL};print $0}' $tableName > temp
		mv temp $tableName
		echo "updated $numOfRows rows successfully"
	fi			

else
echo "table doesn't exist"
fi		
