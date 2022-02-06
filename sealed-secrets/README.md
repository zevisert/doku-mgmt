# sealed-secrets

## Description
sample description

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] sealed-secrets`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree sealed-secrets`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init sealed-secrets
kpt live apply sealed-secrets --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/
