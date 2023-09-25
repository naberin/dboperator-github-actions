#!/bin/bash

IDENTIFICATION=$(python3 get.py "${{ github.event.ref }}")
NAMESPACE="ft-$IDENTIFICATION"

# delete
kubectl delete namespace "$NAMESPACE"