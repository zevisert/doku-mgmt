# mongodb-kubernetes-operator

## Description
Resources required to install the mongodb-kubernetes-operator in "different namespace than resources mode". 


## Usage

### Fetch the package
`kpt pkg get https://github.com/zevisert/doku-mgmt/mongodb-kubernetes-operator mongodb-kubernetes-operator`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree mongodb-kubernetes-operator`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init mongodb-kubernetes-operator
kpt live apply mongodb-kubernetes-operator --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/

### Updating

[mongodb-kubernetes-operator](https://github.com/mongodb/mongodb-kubernetes-operator) tracks resources as plain manifests that are compatible with `kpt`. Use `kpt pkg update` in the subpackages to merge updates.
