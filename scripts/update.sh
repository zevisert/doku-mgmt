#!/bin/bash

set -e

update_custom() {
  UPDATE_DIR="$1"
  OUTPUT_DIR="$2"

  rm -rf "$UPDATE_DIR/charts"
  rm -rf "$OUTPUT_DIR"
  mkdir "$OUTPUT_DIR"

  kustomize build --enable-helm "$UPDATE_DIR" > "$OUTPUT_DIR/deploy.yaml"

  pushd "$OUTPUT_DIR"
  kpt cfg fmt .
  kustomize create --autodetect
  popd
}

update_kpt() {
  kpt pkg update "$1@$2" --strategy resource-merge
}

cert_manager() {
  UPDATE_DIR="scripts/cert-manager"

  if [[ -n "$1" ]]; then
    cat << EOF > "$UPDATE_DIR/kustomization.yaml"
helmCharts:
- name: cert-manager
  releaseName: cert-manager
  repo: https://charts.jetstack.io
  version: $1
  valuesInline:
    installCRDs: true
EOF
  fi

  update_custom "$UPDATE_DIR" "cert-manager/upstream/helm" > /dev/null
}

elastic_cloud() {
  UPDATE_DIR="scripts/elastic-cloud"

  if [[ -n "$1" ]]; then
    cat << EOF > "$UPDATE_DIR/kustomization.yaml"
resources:
- https://download.elastic.co/downloads/eck/$1/all-in-one.yaml
EOF
  fi

  update_custom "$UPDATE_DIR" "elastic-cloud/operator" > /dev/null
}

ingress_nginx() {
  if [[ -z "$1" ]]; then
    echo "version argument is required!"
    exit 1
  fi

  update_kpt "ingress-nginx/upstream" "controller-v$1"
}

case "$1" in

  cert-manager) cert_manager "${@:2}" ;;
  elastic-cloud) elastic_cloud "${@:2}" ;;
  ingress-nginx) ingress_nginx "${@:2}" ;;

  *) echo "no auto-update script available for '$1'" && exit 1 ;;
esac
