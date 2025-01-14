#!/usr/bin/bash

OIFS="$IFS"
IFS=$'\n'

schoollist=`cat school_list.txt`
for school in $schoollist; do
    echo "compiling $school data"

    # Get ELECTRIC data as well as Totals in case we want % of total cost
    egrep -i "Place.*$school" 20*.txt -B 1 -A 8  | grep -i ELECTRIC > tmp-ELECTRIC.txt #${school}-ELECTRIC.txt
    egrep -i "Place.*$school" 20*.txt -B 1 -A 8  | grep Totals > tmp-Totals.txt #${school}-Totals.txt
    paste  tmp-ELECTRIC.txt tmp-Totals.txt > ../school_outputs_ELECTRIC/${school}_electric.xlsx

    # remove all extra spaces
    sed -i 's/\t/ /g' ../school_outputs_ELECTRIC/${school}_electric.xlsx
    sed -i 's/ \s*/ /g' ../school_outputs_ELECTRIC/${school}_electric.xlsx

    # make first column date. files are YYYY-MM, adding 15th as day
    sed -i 's/.txt-/-15 /' ../school_outputs_ELECTRIC/${school}_electric.xlsx

    # convert to xlsx: remove commas from numbers and separate entries by comma
    sed -i 's/,//g' ../school_outputs_ELECTRIC/${school}_electric.xlsx
    sed -i 's/ /, /g' ../school_outputs_ELECTRIC/${school}_electric.xlsx

done

IFS=$OIFS
