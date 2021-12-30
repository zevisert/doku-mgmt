# `ingress-nginx/geoip`

## Usage

Before referencing this component you must create the necessary license key secret:

```shell
echo -n "<maxmind account id>" > secrets/account-id
echo -n "<maxmind license key>" > secrets/license-key

kubectl create secret generic ingress-nginx-maxmind-license --namespace ingress-nginx --from-file secrets/account-id --from-file secrets/license-key --dry-run=client --output yaml > secrets/account.secret.yaml
```

> **NOTE:** These files should not be checked into source control!
