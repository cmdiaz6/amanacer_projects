#!/usr/bin/bash


cd  output_school_data
school_files=`ls *.txt`

echo "generating final stats file episd_stats.xslx in output_school_data/ directory"
cat ../header.txt > episd_stats.xslx

for file in $school_files; do
    # print each file on 1 line separated by commas for easy google sheets upload
    cat $file | paste -sd ' ' | sed 's/ /, /g' >> episd_stats.xslx
done
echo "done. Congratulations"
cd ..
