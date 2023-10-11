#!/bin/bash

IDENTIFICATION=$1

while : ; do
    
    # get status
    STATUS=$(kubectl get -n "ft-$IDENTIFICATION" adb "adb-$IDENTIFICATION" -o 'jsonpath={.status.lifecycleState}')
    # if database is available, end while loop; else sleep
    if [[ "$STATUS" == "AVAILABLE" ]]; then
        break;
    else
        echo "Checking for DB Availability..."
        sleep 5;
    fi;

done;

echo "Database now available."