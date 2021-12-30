# cert-manager

## Description
Resources for an `cert-manager` installation, customized with `kpt` setters and a few overlay resources.

## Usage

### Fetch the package
`kpt pkg get https://github.com/zevisert/doku-mgmt/cert-manager cert-manager`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree cert-manager`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init cert-manager
kpt live apply cert-manager --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/


### Updating

[cert-manager](https://github.com/jetstack/cert-manager/) doesn't track resources as plain manifests that are compatible with `kpt`. Instead, I use the `render-helm-chart` `kpt fn` to compile the upstream sources, see the [upstream/Kptfile](./upstream/Kptfile) for the full command. This overwrites any changes with the forked upstream manifests here, so be sure to perform this merging without any local changes.
