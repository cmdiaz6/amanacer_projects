# Extract utilities data from EPISD and convert to xslx
## compiles by school for electric, natural gas, sewer, and water usage
Some of these steps need to be done in the output directories, not the main directory
I will clean this up eventually

**TODO:** make more automated by putting all of these into one calling script


* ## Pull yearly data from [EPISD Energy Management website](https://www.episd.org/page/energy-management).
**'Download All'** for current and Archives and unpack
`unzip archives.zip`

monthly pdfs should be in year directories e.g. 2023-2024/
* ## Convert pdfs to txt files
### output: text files in output/ with same pdf names (e.g. 'H. Feb 2023 Campus Report.xslx')
`loop_pdf2txt.sh`

(might be missing a step here to rename .txt to .xlsx)

* ## rename files in format "*MON YYYY*.xlsx" to 'YYYY-MM.xlsx'
 e.g. renames 'H. Feb 2023 Campus Report.xlsx' to '2024-02.xlsx'

### output: renames files in-place - old files will be _overwritten_
 **WARNING:** uses 'find .' so only run in output/ directory!

`rename_julian_dates.sh`

* ## Set up list of schools if needed
NOTE: the school list included contains some schools that are closed and some that aren't schools (e.g. Magoffin Custodial)

all of these are probably not needed and maybe new schools will need to be added later

to compile new list run this command after you converted all the pdfs to txt:

`grep "Place:" *Report.txt | grep -o "Place:.*[0-9][0-9] \[" | rev | cut -d" " -f3-99 | rev | sed 's/\s*$//' | sort -u > school_list.txt`

also add 'Summary Report' line at the end of school_list.txt to get EPISD summary statistics: `echo "'Summary Report'" >> school_list.txt`


TODO:should use the codes in brackets (e.g. [WIGGS]) because some names change. Need to remove brackets from output file name

`grep "Place:.*BUILDING" *Report.txt | sed 's/[0-9]* \[BUILDING]//' | grep -o "\[[A-Z0-9_-]*\]"  | sort -u > school_list.txt`

* ## compile data for each utility for each school in school_list.txt
### output: school_outputs_${UTIL}/${school}_${util}.xslx
```
electric-schools.sh
naturalgas-schools.sh
sewer-schools.sh
water-schools.sh
```

* ## compile all 4 utility files into one report. schools listed in file school_list.txt
### output: school_outputs/${school}_report.txt
`compile_schools.sh`

* ## upload files to Google Drive and open as Google Sheet

