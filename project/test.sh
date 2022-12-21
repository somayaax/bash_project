#!/bin/bash
reg='^[a-zA-z_]*$'
str="hagar###t"
#if [[ str =~ ^[a-zA-Z_]*$ ]] && [[ ! str =~ ^[:space:]*$ ]];
#if [[ ! str =~ ^[:space:]$ ]];
if [[ str =~ ^[a-zA-Z_]*$ ]]
then
echo "matched"
fi
