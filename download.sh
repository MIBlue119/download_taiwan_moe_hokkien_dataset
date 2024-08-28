#!/bin/bash

# Base URL for the downloads
BASE_URL="https://tggl.naer.edu.tw/corpus_files/<replace with your download url>"

# Base directory for downloads
BASE_DIR="MOE_Hokkien_Corpus"

# Function to download a file
download_file() {
    local folder=$1
    local filename=$2
    local url="${BASE_URL}/${filename}?disposition=attachment"
    local filepath="${BASE_DIR}/${folder}/${filename}"
    
    mkdir -p "${BASE_DIR}/${folder}"
    
    echo "Downloading ${filename} to ${folder}..."
    curl -L -o "${filepath}" "${url}"
}

# Create base directory
mkdir -p "${BASE_DIR}"

# Download template files
download_file "templates" "apply-template.ods"
download_file "templates" "apply-template.xlsx"

# Download single mic corpus files
for i in $(seq -f "%03g" 1 88); do
    download_file "single_mic_corpus" "tat_moe_corpora_1mic.7z.${i}"
done

# Download full corpus files
for i in $(seq -f "%03g" 1 212); do
    download_file "full_corpus" "corpus-full.7z.${i}"
done

echo "All downloads completed!"