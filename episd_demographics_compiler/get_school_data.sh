#!/usr/bin/bash

OIFS="$IFS"
IFS=$'\n'

categories=`cat categories.txt`
categories_mobility=`cat categories-mobility.txt`
echo $categories_mobility

mkdir -p output_school_data

cd output_pdf_text
pwd
school_files=`ls *TAPR.txt`

for file in $school_files; do
    school_name=$(echo $file | sed 's/TAPR.txt//')
    school=$school_name.txt
    echo 'exporting data for ' $school_name ' to ' $school

    if [ -f "$school" ];then
        rm $school
    fi
    echo $school_name >> $school

    # probably a better way to do this in python that doesn't grep the same data repeatedly
    for field in $categories; do
        # info starts on page 20. Grep 100 lines after 'page 19'. Only get 1st match (head -n 1)
        grep 'Page 19' -A 100 $file | grep -o "$field"' \s*[0-9*][0-9*]*' | head -n 1 | rev | cut -d' ' -f1 | rev >> $school
    done

    echo "---" >> $school # blank line in spreadsheet

    # Mobility statistics
    for field in $categories_mobility; do
        # info starts on page 21. Grep 35 lines after 'page 20' 
        grep 'Page 20' -A 100 $file | grep -o "$field"' \s*[0-9*][0-9*]*' | head -n 1 | rev | cut -d' ' -f1 | rev >> $school
    done

    mv $school ../output_school_data

done

cd ../

IFS=$OIFS
