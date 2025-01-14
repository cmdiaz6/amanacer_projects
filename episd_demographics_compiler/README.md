# compile stats from TEA TAPR pdfs into one spreadsheet

* ## convert pdfs to text
`loop_pdf2txt.sh`

* ## pull only needed data for each school
categories are specified in categories.txt and categories-mobility.txt
`get_school_data.sh`

* ## generate final file combining all schools
`gen_final.sh`
