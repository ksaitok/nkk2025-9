#!/bin/bash

# Script to download nikkei-kaitai.com website
# This script will create an old_site folder and download all content

echo "Starting download of nikkei-kaitai.com..."

# Create old_site directory
mkdir -p old_site
cd old_site

# Download the entire site with wget
# Options:
# -r: recursive download
# -p: download all page requisites
# -k: convert links to make them suitable for local viewing
# -E: adjust extension (.html or .css)
# -nc: no clobber (don't download existing files)
# --random-wait: be polite to the server
# -U: user agent string
# -l 5: limit recursion depth to 5 levels

wget \
  --recursive \
  --page-requisites \
  --convert-links \
  --html-extension \
  --no-clobber \
  --random-wait \
  --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
  --level=5 \
  --domains=nikkei-kaitai.com \
  --no-parent \
  https://nikkei-kaitai.com/

echo "Download completed! Check the old_site folder for the downloaded content."

# Create a summary of what was downloaded
echo "Creating download summary..."
find . -type f | sort > download_summary.txt
echo "Total files downloaded: $(find . -type f | wc -l)" >> download_summary.txt
