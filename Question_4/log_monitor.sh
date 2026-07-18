#!/bin/bash

# 1. Create a dummy log file for testing
touch system_test.log

# 2. Simulate log entries being added in real-time (running in the background)
(
    sleep 1
    echo "INFO: User logged in successfully" >> system_test.log
    sleep 1
    echo "ERROR: Database connection failed (Timeout)" >> system_test.log
    sleep 1
    echo "INFO: Retrying connection..." >> system_test.log
) &

# 3. The actual command pipeline required by the question:
echo "Monitoring logs... (Press Ctrl+C to stop after the error appears)"
tail -f system_test.log 2>/dev/null | grep --line-buffered "ERROR" | tee -a error_report.txt
