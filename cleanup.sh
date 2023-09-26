#!/bin/bash

IDENTIFICATION=$(python get.py "$BRANCH_REF")
NAMESPACE="ft-$IDENTIFICATION"

# patch hardLink set to true
kubectl patch --type=merge adb "adb-$IDENTIFICATION" -p '{"spec": {"hardLink": true}}' -n "$NAMESPACE"

# delete
kubectl delete namespace "$NAMESPACE"