#!/bin/bash
cd ./databases/$1
let slashes=`pwd| tr -cd '/' | wc -c`
let curDB=${slashes}+1
PS3="`pwd | cut -d/ -f${curDB}` >> "

echo "Choose from the following"
COLUMNS=8
select choice in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "back to main menu"
do
case $REPLY in 
1) echo "please enter table name"
   read name
   if [ ! -f $name ]
	then
	echo "please enter number of columns"
	read cols
	re='^[0-9]+$'
	if ! [[ $cols =~ $re ]]
	then
		echo "not a number"
	else
		touch $name
		touch $name.metadata
	
		echo "please enter primary key of the table"
		read primaryKey
		echo -e "please enter type of pk\nint for integer\nstring for string\nchar for character"
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
		echo -e "please enter field ${j} type\nint for integer\nstring for string\nchar for character"
   		read fieldType
		entry=$field:$fieldType
		echo $entry >> $name.metadata
		let i=$i+1
		let j=$j+1
		done
	fi

	else
	echo "Table already exists"
   fi


;;
2) ls | grep -v .metadata$
;;
3)echo "please enter table name"
   read table
   if [ -f $table ]
   then
   rm $table 
   rm $table.metadata
   else
   echo "table doesn't exist"
   fi
;;
4) ../../insert.sh
;;

5) ../../select.sh $1

	#echo -e "enter fields\nall $columns"
	#ans=""
	#answer=""
	#read answer
	#if [ "$answer" = "all" ]
	#then
	#awk -F: 'BEGIN{}{print $0}' $tableName
		
	#else
	#while [ "$answer" != "all" ]
	#do
	#read answer
	#ans=$ans" "$answer
	#done
	#fi



;;
6) echo "6"
;;
7) echo "7"
;;
8) ../../mainmenu.sh
;;
esac
done
