# ingress-nginx

## Description
Resources for an `ingress-nginx` installation, customized with `kpt` setters and a few overlay resources.

## Usage

### Fetch the package
`kpt pkg get https://github.com/zevisert/doku-mgmt/ingress-nginx ingress-nginx`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree ingress-nginx`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init ingress-nginx
kpt live apply ingress-nginx --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/


### Updating

[ingress-nginx](https://github.com/kubernetes/ingress-nginx/) doesn't track resources as plain manifests that are compatible with `kpt`. Instead, I use the `render-helm-chart` `kpt fn` to compile the upstream sources, see the [upstream/Kptfile](./upstream/Kptfile) for the full command. This overwrites any changes with the forked upstream manifests here, so be sure to perform this merging without any local changes.
