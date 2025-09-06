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
