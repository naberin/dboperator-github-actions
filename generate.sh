#!/bin/bash

# set token
IDENTIFICATION=$(python3 get.py "$GITHUB_REF_NAME")
NAMESPACE="ft-$IDENTIFICATION"

#  create namespace
kubectl create namespace "$NAMESPACE"

# kustomize remove if exists
if test -f "kustomization.yaml"; then
  rm kustomization.yaml
fi

# kustomize create
kustomize create --resources base

# create patch
cat <<EOF > ${{ runner.temp }}/patch.yaml
- op: add # action
  path: "/spec/details/compartmentOCID"
  value: ${COMPARTMENT_OCID}
- op: add # action
  path: "/spec/details/dbName"
  value: db${IDENTIFICATION}
- op: add # action
  path: "/spec/details/displayName"
  value: dbtest-${IDENTIFICATION}
EOF

# replacing the image name in the k8s template
kustomize edit set namesuffix "$IDENTIFICATION"
kustomize edit add patch --path ${{ runner.temp }}/patch.yaml --kind AutonomousDatabase
kustomize edit set namespace "$NAMESPACE"

# kubectl apply
kustomize build . | kubectl -n "$NAMESPACE" apply -f -