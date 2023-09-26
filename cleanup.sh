#!/bin/bash

IDENTIFICATION=$(python get.py "$BRANCH_REF")
NAMESPACE="ft-$IDENTIFICATION"

# delete
kubectl delete namespace "$NAMESPACE"