#!/usr/bin/bash
#set -x
# Converts pdfs of all months into text format
# monthly pdfs in year directories e.g. 2023-2025 pulled from episd website

OIFS="$IFS"
IFS=$'\n'

mkdir -p output_pdf_text/
cd inputs
pwd
ls *.pdf > pdf_list.txt
echo "Converting $dir" 

for file in `find . -type f -name "*.pdf"`; do
    base=$(echo $file | sed 's/\s//g')
    text=${base::-4}".txt"
    echo "- - Converting $file to $text"

    pdftotext -layout $file $text

    mv $text ../output_pdf_text/
done
cd ../

IFS=$OIFS
