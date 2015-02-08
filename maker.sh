#! /bin/bash

compileArgs="gcc -Wall -g -std=c99"
removeArgs="rm -f"
invalid() {
	echo "usage: maker.sh executable_name"
    exit 1
}

if [ $# -lt 1 ]; then
	echo "Executable name required."
	invalid
fi

for i in ${@:2} ; do
	if ! [[ $i =~ -.+ ]] ; then
		invalid
	fi
	arguments="$arguments $i"
done

for f in *.c ; do 
	if [[ -f $f ]] ; then
		cleanFilelist="$cleanFilelist ${f%%.c}.o"
		processing=$(grep "^#include \".*\"" $f | sed s/"#include \""/""/ \
			| sed s/"\""/""/ | awk 'END {print ""} // {printf "%s ", $1}')
		body="$body${f%%.cpp}.o : $f $processing\n\t$compileArgs -c$arguments $f\n\n"
	fi
done
doublespace="  "
cleanFilelist2="${cleanFilelist// /$doublespace}"
cleanFilelist2="${cleanFilelist2:2}"
clean="clean : \n\t$removeArgs $1 $cleanFilelist2   \n"
rm -f Makefile
printf "$1 :$cleanFilelist  \n\t$compileArgs -o $1$arguments\
$cleanFilelist  \n\n$body$clean" > Makefile
