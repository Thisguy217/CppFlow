#!/usr/bin/bash

#Make a check for 0 arguments, kicks back in nothing is passed
if [ $# -eq 0 ]; then
	#TODO: provide an echo of all possible commands and not just kick back
	echo "No arguments were passed."
	echo "Early termination."
	exit 1
#Check if it is one or two arguments
elif [ $# -eq 1 ]; then
	#Exectute a run command, which compiles and begins to execute the
	#produced binary in one step given no errors return during compiling
	if [ $1 == "run" ]; then
		g++ -Wall -Werror *.cpp -o main
		if [ $? -eq 0 ]; then
			echo Compilation Complete
			./main
		else
			echo "Error: g++ returned a non-zero exit status."
			exit 1
		fi
	#If build or check is used it will run the compiling command and
	#verify that it will work, it will generate a new binary in each
	#instance regardless of updating.
	elif [ $1 == "build"] || [ $1 == "check" ]; then
		g++ -Wall -Werror *.cpp -o main
		if [ $? -eq 0 ] && [ $1 == "check" ]; then
			echo "Check Passed"
		elif [ $? -eq 0 ] && [ $1 == "build" ]; then
			echo "Build Complete"
		else
			echo "Error: g++ returned a non-zero exit status."
			exit 1
		fi
	else
		echo "Error: Invalid arguemnt."
		exit 1
	fi
#If two arguments are passed it will check what the first one is and
#then run according to the succeeding arguments
elif [ $# -eq 2 ]; then
	if [ $1 == "new" ]; then
		#This handles building the basic project for C++
		mkdir $2 && cd $2
		touch main.cpp
		echo "#include<iostream>" >> main.cpp
		echo "int main (int args, char** argv) {" >> main.cpp
		echo "std::cout << "Hello world!" << std::endl;" >> main.cpp
		echo "return 0;" >> main.cpp
		echo "}" >> main.cpp
	#If a build for release/optimized is requested it will run the following
	elif [ $1 == "build" ]; then
		if [ $2 == "-optimized" ]; then
			g++ -Wall -Werror -O2 *.cpp -o main
			if [ $? -eq 0 ]; then
				echo "Build Complete"
			else
				echo "Error: g++ returned a non-zero exit status."
				exit 1
			fi
		else
			echo "Invalid arguments"
		fi
	else
		echo "Error: Invalid number of arguments."
		exit 1
	fi
else
	echo "Error: Invalid number of arguments."
	echo "Expecting 1 arguments"
	exit 1
fi

#Handles the following
#	build
#	build -optimized
#	check
#	run
#	new <project-name>
