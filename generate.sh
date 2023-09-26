#!/bin/bash

# set token
IDENTIFICATION=$(python get.py "$BRANCH_REF")
NAMESPACE="ft-$IDENTIFICATION"
PATCH_LOC="${TEMP_LOCATION}/patch.yaml"

#  create namespace
kubectl create namespace "$NAMESPACE"

# create secret
kubectl create secret -n "$NAMESPACE"  generic default-admin-password --from-literal=admin-password="$OP_DEF_PWD"



# kustomize remove if exists
if test -f "kustomization.yaml"; then
  rm kustomization.yaml
fi

# kustomize create
kustomize create --resources base

# create patch
cat <<EOF > "$PATCH_LOC"
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
kustomize edit add patch --path "$PATCH_LOC" --kind AutonomousDatabase
kustomize edit set namespace "$NAMESPACE"

# kubectl apply
kustomize build . | kubectl -n "$NAMESPACE" apply -f -