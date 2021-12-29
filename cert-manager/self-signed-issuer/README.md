# `cert-manager/self-signed-issuer`

## Usage

Before referencing this component you must create the necessary TLS secret:

```shell
echo -n "<Certificate>" > secrets/tls.crt
echo -n "<RSA Private Key>" > secrets/tls.key

kubectl create secret tls ca-key-pair --namespace cert-manager --cert secrets/tls.crt --key secrets/tls.key --dry-run=client --output yaml > secrets/ca-key.secret.yaml
```

> **NOTE:** These files should not be checked into source control!
