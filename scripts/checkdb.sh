#!/bin/bash

IDENTIFICATION=$1

while : ; do
    
    # get status
    STATUS=$(kubectl get -n "feature-$IDENTIFICATION" singleinstancedatabase "freedb-$IDENTIFICATION" -o 'jsonpath={.status.Status}')
    # if database is available, end while loop; else sleep
    if [[ "$STATUS" == "Healthy" ]]; then
        break;
    else
        echo "Checking for DB Availability..."
        sleep 5;
    fi;

done;

echo "Database now available."