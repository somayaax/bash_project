echo -e "\nSELECT\n "
read -p "Please enter table name: " tableName
while [ ! -f $tableName -a $tableName ] 
do
	echo "Table doesn't exist"
	read -p "Please enter table name: " tableName
done

PS3="$tableName>>"
numOfCols=`cat $tableName.metadata | wc -l `

columns=`cut -d: -f1 $tableName.metadata`

select choice in "Select all without condition" "Select specific columns without condition" "Select with condition" "exit"
do
case $REPLY in
1)
 	column -t -s: $tableName
	read -p "Back to main menu? [y/n]" ans
	if [ $ans = y ]
		then
		cd ../../
		./secondaryMenu.sh $1
		#else
		#cd ../../
		#./select.sh $1
	fi
;;				
2)
	echo "Choose the columns you want to select"
	select choice in $columns
	do
	if [ $REPLY -gt $numOfCols ]
		then
		echo "Select num from 1 to $numOfCols"
	else 		
	completed="y"
	echo "Select another column? y/n"
	read -s -n1 completed
	
	x="$REPLY"
	arr[$REPLY]=$REPLY
	for i in ${arr[*]}
	do
	x=$x,$i
	done
	
	if [ $completed != n -a $completed != y ]
		then 
		echo "Enter y/n only"
		read -s -n1 completed	
	fi
	if [ $completed == n ]
		then
		cut -d: -f$x $tableName | column -t -s: 

		echo "Return to menu? y/n"
		read -s -n1 menuReturn
		if [ $menuReturn == y ]
		then			
			cd ../../
			./secondaryMenu.sh $1
		else
			../../select.sh $1
		fi
	fi
	fi
	done 
;;
3)	

	let numOfCols=$numOfCols+1
	echo "SELECT -FIELDS- FROM $tableName WHERE -PRIMARYKEY- = -value-"
	echo "Enter the fields you want to select :"
	select choice in "all" $columns
	do
	case $REPLY in
	1) 
		read -p "Enter value of pk " pk
		head -1 $tableName | column -t -s:
		grep -w "^$pk" $tableName | column -t -s: 
	;;
	[2-$numOfCols])
		echo "Choose another column? y/n"
		read -s -n1 comp
	x="$REPLY"
	x=$x,$REPLY
	arr[$REPLY]=$REPLY
	for i in ${arr[*]}
	do
	x=$x,$i
	done
		if [ $comp == n ]
		then	
			read -p "Enter value of pk " pk
			head -1 $tableName |cut -d: -f$x | column -t -s:
			grep -w "^$pk" $tableName | cut -d: -f$x | column -t -s: 

		fi
	;;
	*)echo enter from 1 to $numOfCols
	;;
	esac
	done
;;
4)	
	cd ../../
	./secondaryMenu.sh $1
;;
*)echo enter value from 1 to 3
;;

esac
done	


