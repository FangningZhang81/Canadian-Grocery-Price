#### Preamble ####
# Purpose: Downloads and saves the data from [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)

#### Download data ####
# Define the download link and the destination path for saving the ZIP file
download_link <- "https://jacobfilipp.com/hammerdata/hammer-5-csv.zip"  # Direct download link
save_path <- "data/01-raw_data/hammer-5-csv.zip"  # Path to save the downloaded file

# Download the ZIP file from the specified link in binary mode
download.file(download_link, destfile = save_path, mode = "wb")  # Download file in binary mode


# After the ZIP file is downloaded, navigate to "01-raw_data" to locate the file and click on it. 
# A decompressed folder will appear containing two CSV files.
         
