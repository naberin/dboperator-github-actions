#!/bin/bash

# set token
IDENTIFICATION=$(python get.py "$BRANCH_REF")
NAMESPACE="ft-$IDENTIFICATION"
PATCH_LOC="${RUNNER_TEMP}/patch.yaml"
DBNAME=$(python clean_dbname.py "$IDENTIFICATION")

#  create namespace
kubectl create namespace "$NAMESPACE"

# create secret
kubectl create secret -n "$NAMESPACE" generic default-admin-password --from-literal=default-admin-password="$OP_DEF_PWD"

# kustomize remove if exists
if test -f "kustomization.yaml"; then
  rm kustomization.yaml
fi

# kustomize create
kustomize create --resources base

# create patch
cat <<EOF > patch.yaml
- op: add # action
  path: "/spec/details/compartmentOCID"
  value: ${COMPARTMENT_OCID}
- op: add # action
  path: "/spec/details/dbName"
  value: db${DBNAME}
- op: add # action
  path: "/spec/details/displayName"
  value: dbtest-${IDENTIFICATION}
EOF

# replacing the image name in the k8s template
kustomize edit set namesuffix "$IDENTIFICATION"
kustomize edit add patch --path patch.yaml --kind AutonomousDatabase
kustomize edit set namespace "$NAMESPACE"

# kubectl apply
kustomize build . | kubectl apply -f -

# move
mv patch.yaml "$PATCH_LOC"
