# `cert-manager/account-key`

## Usage

Before referencing this kustomize component in your own `kustomization.yaml`
you must create the necessary token secret files:

```sh

# run one of the following
echo -n "<tls.key>" > secrets/tls.key
```

> **NOTE:** These files should not be checked into source control!
