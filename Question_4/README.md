### Question 4 Explanations

* `tail -f system_test.log`: I used `tail -f` to continuously monitor the log file in real-time as new entries are appended to it.
* `2>/dev/null`: I redirected standard error to `/dev/null` to immediately suppress and discard irrelevant warnings like "Permission denied" or missing files.
* `| grep --line-buffered "ERROR"`: I piped the stream into `grep` to filter out all lines except those containing "ERROR", using `--line-buffered` to ensure real-time flow without delay.
* `| tee -a error_report.txt`: I piped the filtered output into `tee -a`, which simultaneously displays the critical errors on the terminal screen and appends them to a persistent report file.
