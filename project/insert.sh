#!/bin/bash
echo -e "\nINSERT\n "
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


read -p "Please enter table name: " table
while [ ! -f $table -a $table ] 
do
	echo "Table doesn't exist exist"
	read -p "Please enter table name: " table
done

choose="y"
while [ $choose = y ]
do
#loop to show fields to  user
	record="-1"
	for field in `cut -d: -f1,2 ./$table.metadata` # example : field -> id:int
		do
			read -p  "Please enter $field " newField
			while [ ! $newField ]
			do
	 			echo "No field was entered "
				read -p "Please enter $field " newField
			done
			checkDataType $newField $field
			check=$?
			#while user is entering wrong values
			while [ $check = 0 ]
			do
				echo "Data types doesn't match"
				read -p "Please enter $field " newField
				checkDataType $newField $field
				check=$?
			done
			#if this is the first field (PK) 
			#check if it's not duplicated
			if [ $record = -1 ]
			then
				zero="0"
				negative="-"
				if grep -wq "^$newField" ./$table
				then
				echo "value exists"
				break
				fi
				if [[ "${newField}" =~ ^[0-] ]]; 
				then
				echo "primary key can't begin with zero or negativen"
				break
				fi
				if grep -wq "^$negative" ./$table
				then
				echo "primary key can't begin with -"
				break	
				fi
				record=$newField
			else
				record=$record:$newField
			fi
		done

	#add record to file
	if [ $record != -1 ]
	then
		echo $record >> $table
	fi	

	read -p "Do you want to enter another record? [y/n]" choose
done
cd ../../
./secondaryMenu.sh $1

