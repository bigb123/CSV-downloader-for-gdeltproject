# CSV downloader

That's a simple BASH script to download a zipped CSV files. These files are created with 
15 mins timestamp thus it's easy to guess what would be the name of the next file.

This script is in development phase so it's quite verbose and is mostly hardcoded (no parameters so far).

It's designed to download files **from** given date **to** given date. Thus, feel free to modify `from` and `to` variables
as needed (around line 25-26 in the `download_csv.sh` file). 

## Dependencies

These commands have to be present in your command line:

- `wget`
- `unzip`

## How to run

Run the script with `./download_csv.sh` or if it doesn't work: `bash download_csv.sh`.

### Expected behaviour

The scirpt will download each file to the current directory and extract it in place.