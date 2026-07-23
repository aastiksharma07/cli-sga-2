#!/bin/bash

# Initialize variables
BACKUP_DIR="backup_unique"
ERROR_FILE="error.log"
REPORT_FILE="report.txt"
TOTAL=0
DUPLICATE=0
UNIQUE=0

# Create necessary directories and clear previous state
mkdir -p "$BACKUP_DIR"
> seen_hashes.txt
> "$ERROR_FILE"

# Iterate through all files in submissions directory
for file in submissions/*; do
    if [ -f "$file" ]; then
        ((TOTAL++))
        
        # LINUX FIX: Used md5sum and awk instead of macOS md5 -q
        file_hash=$(md5sum "$file" 2>> "$ERROR_FILE" | awk '{print $1}')
        
        # Check if hash exists in seen_hashes.txt
        if grep -q "$file_hash" seen_hashes.txt 2>> "$ERROR_FILE"; then
            ((DUPLICATE++))
        else
            echo "$file_hash" >> seen_hashes.txt
            cp "$file" "$BACKUP_DIR/" 2>> "$ERROR_FILE"
            ((UNIQUE++))
        fi
    fi
done

# Generate Report
echo "--- Submission Report ---" > "$REPORT_FILE"
echo "Total files processed: $TOTAL" >> "$REPORT_FILE"
echo "Unique files backed up: $UNIQUE" >> "$REPORT_FILE"
echo "Duplicate files found: $DUPLICATE" >> "$REPORT_FILE"

# Cleanup temporary file and display report
rm seen_hashes.txt
cat "$REPORT_FILE"
