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
#loop to show tables to user
printf "enter table name: "
read table
if [ -f $table ]
then
choose="y"
while [ $choose = y ]
do
#loop to show fields to  user
	record="-1"
	for field in `cut -d: -f1,2 ./$table.metadata`
		do
			printf "enter $field"
			read newField
			while [ ! $newField ]
			do
	 			echo "no field entered "
				printf "enter $field "
				read newField
			done
	
			checkDataType $newField $field
			check=$?
			while [ $check = 0 ]
			do
				echo "data types doesn't match"
				printf "enter $field "
				read newField
				checkDataType $newField $field
				check=$?
			done
			#if this is the first field don't add colon
			if [ $record = -1 ]
			then
				if grep -wq "^$newField" ./$table
				then
				echo "value exists"
				break		
				else
				record=$newField
				fi
			else
				record=$record:$newField
			fi
		done

	#add record to file
	if [ $record != -1 ]
	then
		echo $record >> $table
	fi	

	echo "Do you want to enter another record? [y/n]"
	read choose
done
cd ../../
./secondaryMenu.sh $1
else
echo "table doesn't exist"
fi
