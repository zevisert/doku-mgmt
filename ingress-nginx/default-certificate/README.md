# `ingress-nginx/default-certificate`

## Usage

Before referencing this kustomize component in your own `kustomization.yaml`
you must create the necessary token secret files:

```sh
echo -n "<tls.key>" > secrets/tls.key
echo -n "<tls.crt>" > secrets/tls.crt
```

> **NOTE:** These files should not be checked into source control!
