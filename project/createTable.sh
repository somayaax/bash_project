#!/bin/bash

read -p "Please enter table name :" name
while [ -f $name -o ! $name ] 
do
	echo "Table already exist"
	read -p "Please enter table name  :" name
done
#create files for table
touch $name
touch $name.metadata
read -p  "Please enter number of columns " cols
while [ ! $cols ]
do
	read -p  "Please enter number of columns " cols
done

read -p  "Please enter primary key of the table " primaryKey

while [ ! $primaryKey ]
do
read -p  "Please enter primary key of the table " primaryKey
done


header=$primaryKey
read -p "please enter type of the primary key [ int-string-float ] " primaryKeyType
while [[ $primaryKeyType != "int" ]] && [[ $primaryKeyType != "string" ]] && [[ $primaryKeyType != "float" ]] || [[ ! $primaryKeyType ]]
do
echo -e "\nWrong input ! please enter [ int-string-float ]\n"
read -p "please enter type of the primary key: " primaryKeyType
done

pk=$primaryKey:$primaryKeyType
echo $pk >> $name.metadata

let cols=$cols-1
i=0
j=2
while [ $i -lt $cols ]
	do
	read -p  "please enter field ${j} name :" field	
	columnExists=`cut -d: -f1 $name.metadata | grep -w $field  2> /dev/null` 
	while [[ $columnExists ]] || [[ ! $field ]]
	do	
		if [ $columnExists ]
		then 
		echo "column already exist in table $name"
		read -p  "please enter field ${j} name :" field
		columnExists=`cut -d: -f1 $name.metadata | grep -w $field 2> /dev/null`
		elif [  ! $field  ] 
		then
	read -p  "please enter field ${j} name :" field	
	columnExists=`cut -d: -f1 $name.metadata | grep -w $field  2> /dev/null` 
		fi	
	done
	
	read -p "please enter field ${j} type [ int-string-float ] " fieldType

	while [[ $fieldType != "int" ]] && [[ $fieldType != "string" ]] && [[ $fieldType != "float" ]] || [[ ! $fieldType ]]	
		do
		echo -e "\nWrong input ! please enter [ int-string-float ]\n"
		read -p "please enter field ${j} type: " fieldType
	done
	header=$header:$field
	entry=$field:$fieldType
	echo  $entry >> $name.metadata
	let i=$i+1
	let j=$j+1
	done
echo $header >> $name




