#!/usr/bin/bash
#set -x
# Converts pdfs of all months into text format
# monthly pdfs in year directories e.g. 2023-2025 pulled from episd website

OIFS="$IFS"
IFS=$'\n'

#dirlist=`ls 20* -d`
dirlist=`ls 202* -d`
for dir in $dirlist; do
    cd $dir
    pwd
    ls > pdf_list.txt
    echo "Converting $dir" 
    
    for file in `find . -type f -name "*.pdf"`; do
        text=${file::-4}".txt"
        echo "- - Converting $file to $text"

        pdftotext -layout $file 

        #sed -i '/%/d' $text
        sed -i '/^\s*$/d' $text

        mv $text ../output/

        #for school in `cat school_list.txt`; do
        #    egrep "(site|place):.*$school * -B 1 -A 8  | grep -i ELECTRIC > ${school}-ELECTRIC.txt
        #    egrep "(site|place):.*$school * -B 1 -A 8  | grep Totals > ${school}-Totals.txt
        #    paste  ELECTRIC Totals > ${school}_report.txt
        #done
    done
    cd ../
done

IFS=$OIFS
