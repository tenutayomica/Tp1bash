#!/bin/bash

OPTION=0

#catching parameters and getting OPTION from parameter if it exists
if [[ $1 == "-h" ]] ; then
	echo "print help message here"
	exit
elif [[ $1 == "-d" ]] ; then
	echo "delete option chosen"
	exit
elif [[ $1 == "-o"[1-6] ]] ; then 
	OPTION=$( echo "$1" | sed "s/[^1-6.]*//g" )
elif [[ -n $1 ]] ; then 
	echo "wrong usage, run ./EP1 -h for help"
	exit
fi
echo $OPTION
#print menu
