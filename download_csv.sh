#!/usr/bin/env bash
 
#
# Script that downloads zipped csv files
#
 
#
# URL example: http://data.gdeltproject.org/gdeltv2/20211022083000.export.CSV.zip 
#
# URL construction:
# - The file name consist of timestamp: YYYY MM DD hh mm ss (2021 10 22 08 30 00)
# - it's 24 hour mode, not 12 (eg. it's 15 not 3pm) 
# - files are on the server with 15 mins interval (2021 10 22 08 30 00, 2021 10 22 08 45 00, 2021 10 22 09 00 00 and so on)
#
 
URL_BASE='http://data.gdeltproject.org/gdeltv2/'
FILE_SUFFIX='00.export.CSV.zip' # we will ignore seconds from timestamp
# to avoid human mistake if user will prvide some seconds on the end
TRESHOLD=15
CSV_FILES_CATALOG=csv_files
ZIP_FILES_CATALOG=zip_files

dates_list=(
    2015-3-19
    2015-3-20
    2017-3-11
    2017-3-12
    2017-3-13
    2017-9-2
    2017-9-3
    2017-9-4
    2018-1-29
    2018-1-30
    2018-4-24
    2018-4-25
    2019-6-10
    2018-6-17
    2018-6-18
    2020-10-11
    2020-10-12
)


# mkdir -p $CSV_FILES_CATALOG
    mkdir -p $ZIP_FILES_CATALOG
    cd $ZIP_FILES_CATALOG


for date_value in ${dates_list[@]}; do
    from="$date_value 00:00:00"
    to="$date_value 23:45:00"
    
    # Let's convert provided dates to timestamps
    timestamp_from=$(date -d "$from" +'%Y%m%d%H%M')
    timestamp_to=$(date -d "$to" +'%Y%m%d%H%M')

    # We're going to add 15 to "from date" and download the file in the loop.
    # Eventually we'll get to the point where "from date" is bigger than "to date" - that
    # means we have to stop. 
    while [ $timestamp_from -le $timestamp_to ]; do
        Echo "Downloading for date $from"
        echo "Downloading file ${timestamp_from}${FILE_SUFFIX}"
    
        # Download file
        wget --no-clobber -P $ZIP_FILES_CATALOG ${URL_BASE}${timestamp_from}${FILE_SUFFIX}
        # unzip ${timestamp_from}${FILE_SUFFIX} 
        # -d ../$CSV_FILES_CATALOG
        # rm ${timestamp_from}${FILE_SUFFIX}
    
        # Increment the date
        from=$(date -d "$from $TRESHOLD mins")
        timestamp_from=$(date -d "$from" +'%Y%m%d%H%M')
    done
done