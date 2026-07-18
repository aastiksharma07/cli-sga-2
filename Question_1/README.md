### Question 1 Explanations

* `mkdir -p "$BACKUP_DIR" 2>> "$ERROR_FILE"`: I created the backup directory and used `2>>` to redirect any standard errors (like permission issues) into a separate error log without interrupting the script.
* `md5 -q "$file"`: I used the `md5` command to generate a unique hash based on the file's content, which reliably identifies duplicate submissions even if the filenames are different.
* `grep -q "$file_hash" seen_hashes.txt 2>> "$ERROR_FILE"`: I used `grep` in quiet mode (`-q`) to check if the generated hash already exists in my tracking file, identifying it as a duplicate if found.
