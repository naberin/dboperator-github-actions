#!/bin/bash

IDENTIFICATION=$(python3 get.py "$GITHUB_REF_NAME")
NAMESPACE="ft-$IDENTIFICATION"

# delete
kubectl delete namespace "$NAMESPACE"