# `cert-manager/account-key`

## Usage

Before referencing this component you must create the necessary token secret files:

```shell
echo -n "<letsencrypt account key>" > secrets/account-key

kubectl create secret generic letsencrypt-account-key --namespace cert-manager --from-file tls.key=secrets/account.key --dry-run=client --output yaml > secrets/account-key.secret.yaml
```

> **NOTE:** These files should not be checked into source control!
