#!/bin/bash
##############################
# Check the status of apache2 web service 
# If not running, notify service is not running
# If service is running then validate the last 10 lines of the access log for any 500 errors
# If 500 errors found more than threshoald, notify admin with the count of errors 
# if 500 errors not found, notify service is running fine
# validate the error log for any critical errors
# If critical errors found, more than threshoald notify admin with the last 10 lines of error log
# Author: Sampath
##############################
SERVICE="apache2"
LOG_FILE="/var/log/apache2/access.log"
Err_Log="/var/log/apache2/error.log"
CHECK_INTERVAL=300  # 5 minutes

while true; do
    # Check if the service is running
    if systemctl is-active --quiet $SERVICE; then
        echo "$SERVICE is running."

        # Check the last 10 lines of the log file for 500 errors
        ERROR_COUNT=$(tail -n 10 $LOG_FILE | grep -c " 500 ")

        if [ "$ERROR_COUNT" -gt 0 ]; then
            echo "Alert: Found $ERROR_COUNT '500 Internal Server Error' in the last 10 lines of $LOG_FILE."
        else
            echo "No '500 Internal Server Error' found in the last 10 lines of $LOG_FILE. Service is running fine."
        fi
    else
        echo "Alert: $SERVICE is not running!"
    fi
    # Check the error log for critical errors
    CRITICAL_ERRORS=$(grep -i "crit" $Err_Log | tail -n 10)
    if [ -n "$CRITICAL_ERRORS" ]; then
        echo "Alert: Critical errors found in $Err_Log:"
        echo "$CRITICAL_ERRORS"
    else
        echo "No critical errors found in $Err_Log."
    fi  

    # Wait for the specified interval before checking again
    sleep $CHECK_INTERVAL
done


