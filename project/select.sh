
printf "enter table name: "
read tableName
PS3="$tableName>>"

if [ -f $tableName -a $tableName ]
then
	columns=`cut -d: -f1 $tableName.metadata`

	select choice in "select all without condition" "select specific columns without condition" "select with condition"
	do
	case $REPLY in
	1)
	 	column -t -s: $tableName
		echo back to main menu? y/n
		read ans 
		if [ $ans = y ]
			then
			cd ../../
			./secondaryMenu.sh $1
		fi
	;;				
	2)	echo "choose the columns you want to select"
		select choice in $columns
		do
		completed="y"
		echo "select another column? y/n"
		read -s -n1 completed
		
		x="$REPLY"
		arr[$REPLY]=$REPLY
		for i in ${arr[*]}
		do
		x=$x,$i
		done
		
		if [ $completed != n -a $completed != y ]
			then 
			echo "enter y/n only"
			read -s -n1 completed	
		fi
		if [ $completed == n ]
			then
			cut -d: -f$x $tableName | column -t -s: 

			echo "return to menu? y/n"
			read -s -n1 menuReturn
			if [ $menuReturn == y ]
			then			
				cd ../../
				./secondaryMenu.sh $1
			fi
		fi

		done 
	;;
	3)	
		numOfCols=`cat $tableName.metadata | wc -l `
		let numOfCols=$numOfCols+1
		echo "SELECT -FIELDS- FROM $tableName WHERE -PRIMARYKEY- = -value-"
		echo "enter the fields you want to select :"
		select choice in "all" $columns
		do
		case $REPLY in
		1) 
			echo "enter value of pk "
			read pk
			head -1 $tableName | column -t -s:
			grep -w "^$pk" $tableName | column -t -s: 
		;;
		[2-$numOfCols])
 			echo "choose another column? y/n"
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
				echo "enter value of pk "
				read pk
				head -1 $tableName |cut -d: -f$x | column -t -s:
				grep -w "^$pk" $tableName | cut -d: -f$x | column -t -s: 
			fi
		;;
		*)echo enter from 1 to $numOfCols
		;;
		esac
		done
	;;
	esac
	done	
else
echo "table doesn't exist"
fi		

