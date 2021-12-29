# mongodb-kubernetes-operator

## Description
sample description

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] mongodb-kubernetes-operator`
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
