#!/bin/bash

set -e

# region: Utility functions

# shellcheck disable=SC2120
pushd() {
  command pushd "$@" >/dev/null
}

# shellcheck disable=SC2120
popd() {
  command popd "$@" >/dev/null
}

update_custom() {
  UPDATE_DIR="$1"
  OUTPUT_DIR="$2"

  rm -rf "$UPDATE_DIR/charts"
  rm -rf "$OUTPUT_DIR"
  mkdir "$OUTPUT_DIR"

  kustomize build --enable-helm "$UPDATE_DIR" > "$OUTPUT_DIR/deploy.yaml"

  pushd "$OUTPUT_DIR"
  kpt fn eval --image gcr.io/kpt-fn/format:v0.1
  kustomize create --autodetect
  popd
}

update_kpt() {
  kpt pkg update "$1@$2" --strategy resource-merge
}

# endregion: Utility functions

# region: Package handlers

cert_manager() {
  UPDATE_DIR="scripts/cert-manager"

  if [[ -n "$1" ]]; then
    cat << EOF > "$UPDATE_DIR/kustomization.yaml"
helmCharts:
- name: cert-manager
  releaseName: cert-manager
  namespace: cert-manager
  repo: https://charts.jetstack.io
  version: $1
  valuesInline:
    global:
      leaderElection:
        namespace: cert-manager
    installCRDs: true
EOF
  fi

  update_custom "$UPDATE_DIR" "cert-manager/upstream/helm"
}


ingress_nginx() {
  if [[ -z "$1" ]]; then
    echo "version argument is required!"
    exit 1
  fi

  update_kpt "ingress-nginx/upstream" "controller-v$1"
}



elastic_cloud() {
  UPDATE_DIR="scripts/elastic-cloud"

  if [[ -n "$1" ]]; then
    cat << EOF > "$UPDATE_DIR/kustomization.yaml"
resources:
- https://download.elastic.co/downloads/eck/$1/all-in-one.yaml
EOF
  fi

  update_custom "$UPDATE_DIR" "elastic-cloud/operator"
}

gitlab_runner() {
  if [[ -z "$1" ]]; then
    echo "version argument is required!"
    exit 1
  fi

  kpt cfg set "gitlab-runner" runner.version "v$1" --set-by package-default >/dev/null
}


kube_state_metrics() {
  if [[ -z "$1" ]]; then
    echo "version argument is required!"
    exit 1
  fi

  update_kpt "kube-state-metrics/upstream" "v$1"

  pushd "kube-state-metrics"
  kustomize edit remove resource upstream/*
  kustomize edit add resource upstream/*.yaml
  popd
}

# endregion: Package handlers 

case "$1" in

  cert-manager) cert_manager "${@:2}" ;;
  ingress-nginx) ingress_nginx "${@:2}" ;;

  *) echo "no auto-update script available for '$1'" && exit 1 ;;
esac
