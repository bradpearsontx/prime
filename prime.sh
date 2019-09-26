#!/bin/bash
#Setting variables based on input from the user
number1="$1"
number2="$2"
varcount="$#"

#If no input was provided, then ask the user for the required information.
setvariables () {
if [ $varcount -eq 0 ]
then
	echo "Provide the first number:"
	        read number1
        echo "Provide the second number:"
	        read number2
else
	echo "Thank you for providing two inputs!"
fi
}
#Check the variables provided to be sure they are not strings.
checkinteger () {
if ! [ $number1 -eq $number1 ] 2> /dev/null
then
	echo "Please provide integers only."
	exit 1
fi

if ! [ $number2 -eq $number2 ] 2> /dev/null
then
	echo "Please provide integers only."
	exit 1
fi
}	
#Compare the two numbers to determine which is smaller or if they are the same.
setcomparison () {
if [ $number1 -gt $number2 ]
then 
	lower="$number2"
	higher="$number1"

elif [ $number1 -lt $number2 ]
then
	lower="$number1"
	higher="$number2"
	
elif [ $number1 -eq $number2 ]
then
	echo "Please provide different numbers to compare."
	exit 1
fi
if [ $lower -lt "0" ]
then
        echo "The numbers provided cannot be less than 0."
	exit 1
fi
}
#Check the numbers between to see if they are prime numbers.
checkprime () {
#echo "Checking $prime" #Used in testing/debugging only
#The numbers 2 and 3 are prime numbers and do not work in the math below
if [ $prime -eq 2 ] || [ $prime -eq 3 ]
then
	echo "$prime is a prime number."
	return 1
elif [ $prime -gt 3 ]
then
	#math based off https://en.wikipedia.org/wiki/Primality_test
	if [ $(($prime % 2)) -eq 0 ] || [ $(($prime % 3)) -eq 0 ]
	then
#		echo "This number is not a prime number." #Used in testing/debugging only
		return 0
	fi
	i=5; n=2
	while [ $((i * i)) -le $prime ]; do
		if [ $(($prime % i)) -eq 0 ]
		then
#			echo "This number is a not a prime number." #Used in testing/debugging only
			return 0
		fi
	i=$((i + n))
	n=$((6 - n))
	done
	echo "$prime is a prime number."
else
	echo "Something went wrong."
fi
}
setvariables
checkinteger
setcomparison

#Output of the numbers provided #Used in testing/debugging only
#echo "The first number provided was: $number1" #Used in testing/debugging only
#echo "The second number provided was: $number2" #Used in testing/debugging only
#echo "The lower number was $lower" #Used in testing/debugging only
#echo "The higher number was $higher" #Used in testing/debugging only

#Increasing intervals for prime test
prime=$(( $lower + 1 ))
while [ $prime -lt $higher ]; do
	checkprime
	prime=$(( $prime + 1 ))
done

