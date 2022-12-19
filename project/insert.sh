#!/bin/bash
function checkDataType {
echo "PARAM 1"
echo $1
echo "PARAM 2"
echo $2
if [[ $1 =~ ^[+-]?[0-9]+$ ]] && [[ $2 =~ int$ ]]; then
echo " integers"

elif [[ $1 =~ ^[+-]?[0-9]+\.$ ]]  && [[ $2 =~ string$ ]]; then
echo "strings"

elif [[ $1 =~ ^[+-]?[0-9]+\.?[0-9]*$ ]] && [[ $2 =~ float$ ]]; then
echo "float"

else
echo "Different"
fi
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
				printf "enter $field"
				read newField
			done
	
			#if this is the first field don't add colon
			checkDataType $newField $field
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
		let current=$current+1
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
