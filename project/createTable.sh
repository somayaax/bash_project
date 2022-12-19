#!/bin/bash

echo "please enter table name"
read name  
if [ ! -f $name ]
	then 
	touch $name
	touch $name.metadata
	echo "please enter number of columns"
	read cols
	
	echo "please enter primary key of the table "
	read primaryKey
	header=$primaryKey
	echo -e "please enter type of the primary key\nint for integer\nstring for string\nfloat for float \n"
	read primaryKeyType
	pk=$primaryKey:$primaryKeyType
	echo $pk >> $name.metadata

	let cols=$cols-1
	i=0
	j=2
	while [ $i -lt $cols ]
		do
		echo "please enter field ${j} name"
		read field
		echo -e  "please enter field ${j} type \nint for integer\nstring for string\nfloat for float\n"
		read fieldType
		header=$header:$field
		entry=$field:$fieldType
		echo  $entry >> $name.metadata
		let i=$i+1
		let j=$j+1
		done
echo $header >> $name
else
echo "table already exist"
fi


