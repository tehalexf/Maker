# Maker
Bash script to automate creating makefiles for valid c projects.

How to use:

Copy the script, naming it as maker.sh

Give it execute rights:
chmod u+x maker.sh


Put it in a directory with the c files you wish to generate a makefile for.


Run it using
./maker.sh < name of executable you want >


Ex:
./maker.sh test.out


Assuming your c files are correct, this will generate the correct Makefile that generates a test.out from the files in the directory.


Only supports ONE main function within one project.
