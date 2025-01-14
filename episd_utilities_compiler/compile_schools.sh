#!/usr/bin/bash

OIFS="$IFS"
IFS=$'\n'

schoollist=`cat schoollist`
for school in $schoollist; do
    echo "compiling $school data"
    egrep -i "Place:.*$school * -B 1 -A 6  | grep -i ELECTRIC > tmp-ELECTRIC.txt #${school}-ELECTRIC.txt
    egrep -i "Place:.*$school * -B 1 -A 6  | grep Totals > tmp-Totals.txt #${school}-Totals.txt
    paste  tmp-ELECTRIC.txt tmp-Totals.txt > ../school_outputs/${school}_report.txt
    sed -i 's/\t/ /g' ../school_outputs/${school}_report.txt
    sed -i 's/ \s*/ /g' ../school_outputs/${school}_report.txt
    sed -i 's/.txt-/-15 /' ../school_outputs/${school}_report.txt
done
