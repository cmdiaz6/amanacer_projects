# compile stats from TEA TAPR pdfs into one spreadsheet

* ## convert pdfs to text
### output: output_pdf_text/${name}.txt
`loop_pdf2txt.sh`

* ## pull only needed data for each school
### output: output_school_data/${school}.txt
categories are specified in categories.txt and categories-mobility.txt

`get_school_data.sh`

* ## generate final file combining all schools
### output: output_school_data/episd_stats.xslx
`gen_final.sh`
