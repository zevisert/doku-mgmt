#!/bin/bash

set -e

update() {
  UPDATE_DIR="$1"
  OUTPUT_DIR="$2"

  rm -rf "$OUTPUT_DIR"
  mkdir "$OUTPUT_DIR"

  kustomize build --enable-helm "$UPDATE_DIR" > "$OUTPUT_DIR/deploy.yaml"

  pushd "$OUTPUT_DIR"
  kpt cfg fmt .
  kustomize create --autodetect
  popd
}

elastic_cloud() {
  update "scripts/elastic-cloud" "elastic-cloud/upstream" > /dev/null
}

cert_manager() {
  update "scripts/cert-manager" "cert-manager/upstream/helm" > /dev/null
}

case "$1" in

  cert-manager) cert_manager ;;
  elastic-cloud) elastic_cloud ;;

  *) exit 1 ;;
esac
