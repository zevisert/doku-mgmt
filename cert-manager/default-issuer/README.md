# `cert-manager/default-issuer`

## Usage

Before referencing this component you must create the necessary access token secret:

```shell
echo -n "<Digitalocean Access Token>" > secrets/access-token

kubectl create secret generic digitalocean-dns --namespace cert-manager --from-file secrets/access-token --dry-run=client --output yaml > secrets/digitalocean-dns.secret.yaml
```

> **NOTE:** These files should not be checked into source control!
