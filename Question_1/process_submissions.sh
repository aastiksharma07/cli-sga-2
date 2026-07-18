#!/bin/bash

SUB_DIR="submissions"
BACKUP_DIR="backup_unique"
REPORT_FILE="report.txt"
ERROR_FILE="error.log"

mkdir -p "$BACKUP_DIR" 2>> "$ERROR_FILE"

TOTAL=0
UNIQUE=0
DUPLICATE=0

> seen_hashes.txt

for file in "$SUB_DIR"/*; do
    if [ -f "$file" ]; then
        ((TOTAL++))
        
        file_hash=$(md5 -q "$file" 2>> "$ERROR_FILE")
        
        if grep -q "$file_hash" seen_hashes.txt 2>> "$ERROR_FILE"; then
            ((DUPLICATE++))
        else
            echo "$file_hash" >> seen_hashes.txt
            cp "$file" "$BACKUP_DIR/" 2>> "$ERROR_FILE"
            ((UNIQUE++))
        fi
    fi
done

echo "--- Submission Report ---" > "$REPORT_FILE"
echo "Total files processed: $TOTAL" >> "$REPORT_FILE"
echo "Unique files backed up: $UNIQUE" >> "$REPORT_FILE"
echo "Duplicate files found: $DUPLICATE" >> "$REPORT_FILE"

rm seen_hashes.txt
cat "$REPORT_FILE"
