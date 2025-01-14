#!/usr/bin/bash
# renames files in format "*MON YYYY*.xlsx" to 'YYYY-MM.xlsx'
# e.g. 'H. Feb 2023 Campus Report.xlsx' to '2024-02.xlsx'
#set -x

OIFS="$IFS"
IFS=$'\n'

#for file in `find . -type f -name "*.txt"`; do
for file in `find . -type f -name "*.xlsx"`; do


    MonYear=`echo $file | grep -o "[a-zA-Z.]*\s*[0-9][0-9][0-9][0-9]" | head -n 1`
    echo "file: $file  MonYear: $MonYear"

    month=`echo $MonYear | grep -o "[a-zA-Z]*"`
    year=` echo $MonYear | grep -o [0-9][0-9][0-9][0-9]`
    echo "month: $month  year: $year"
    
    newdate='xxx'
    newdate=`date -d "$month 1 $year" "+%Y-%m"`

    name="$newdate.xlsx"
    echo "renaming $file to $name"
    mv $file $name
done

IFS="$OIFS"
