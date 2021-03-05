#!/bin/bash

CERT_MANAGER_VERSION=${1:-"v1.2.0"}

CURRENT_DIR=$(pwd)
SCRATCH="$CURRENT_DIR/.build"
TEMPLATE_PATH="cert-manager/upstream"
HELM_PATH="$TEMPLATE_PATH/helm"

helm repo add jetstack https://charts.jetstack.io
helm repo update

echo "Building manifests for diff checking ..."
rm -rf "$SCRATCH"
mkdir "$SCRATCH"
kustomize build "$TEMPLATE_PATH" > "$SCRATCH/before.yaml"

rm -rf "$HELM_PATH"

echo "Using cert-manager $CERT_MANAGER_VERSION ..."
helm template cert-manager jetstack/cert-manager --version $CERT_MANAGER_VERSION --set installCRDs=true --output-dir "$HELM_PATH"
mv $HELM_PATH/cert-manager/templates/* "$HELM_PATH"
rm -rf "$HELM_PATH/cert-manager"

cd "$TEMPLATE_PATH"

for file in $(find helm/ -type f -name '*.yaml' | sort); do
  kustomize edit add resource $file
done

cd "$CURRENT_DIR"

# Format helm templates for consistent diff
kpt cfg fmt "$TEMPLATE_PATH"

kustomize build "$TEMPLATE_PATH" > "$SCRATCH/after.yaml"

diff --color "$SCRATCH/before.yaml" "$SCRATCH/after.yaml"
