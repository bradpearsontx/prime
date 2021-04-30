#!/bin/bash
#Check the variables provided to be sure they are not strings.
check_integer () {
	if ! [ $1 -eq $1 ] 2> /dev/null
	then
		return 0 
	else
	return 1
	fi
}

#Check variables for negative numbers
check_negative (){
	if [ $1 -lt 0 ]
	then
		return 0
	else
	return 1
	fi
}

#Compare the two numbers to determine which is smaller or if they are the same.
check_swapped_inputs () {
	if [ $1 -gt $2 ]
	then 
		l="$2"
		h="$1"
	elif [ $1 -lt $2 ]
	then
		l="$1"
		h="$2"
	elif [ $1 -eq $2 ]
	then
		echo "$1 and $2 must be different."
		exit
	fi
	number1=$l
	number2=$h
}

#Print if the input is a prime number.
print_prime () {
	prime=$1
	if [ $prime -eq 1 ]
	then
		return 0
	elif [ $prime -eq 2 ] || [ $prime -eq 3 ]
	then
		echo -n "$prime "
		return 1
	elif [ $prime -gt 3 ]
	then
		#math based off https://en.wikipedia.org/wiki/Primality_test
		if [ $(($prime % 2)) -eq 0 ] || [ $(($prime % 3)) -eq 0 ]
		then
			return 0
		fi
		i=5
		while [ $((i * i)) -le $prime ]; do
			if [ $(($prime % i)) -eq 0 ] || [ $(($prime % ( i + 2 ))) -eq 0 ]
			then
				return 0
			fi
		i=$((i + 6))
		done
		echo -n "$prime "
	else
		echo "Something went wrong."
	fi
}

#Checking for inputs
if [ $# -lt 2 ]
then
	echo "Usage: $0 <number 1> <number 2>"
	exit 1
elif [ $# -gt 2 ]
then
	echo "Usage: $0 <number 1> <number 2>"
	echo "Too many arguments."
	exit 1
fi

#Setting variables based on input from the user
number1="$1"
number2="$2"

if check_integer $number1 || check_integer $number2
then
	echo >&2 "Input must be integers."
	exit 1
fi

if check_negative $number1 || check_negative $number2
then
	echo >&2 "Input must be higher than 0."
	exit 1
fi
check_swapped_inputs $number1 $number2

lower=$number1
higher=$number2

#Increasing intervals for prime test
prime=$lower
while [ $prime -le $higher ]; do
	print_prime $prime
	prime=$(( $prime + 1 ))
done
echo 
