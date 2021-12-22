# ingress-nginx

## Description
sample description

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] ingress-nginx`
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
