# `gitlab-runner/tokens`

## Usage

Before referencing this kustomize component in your own `kustomization.yaml`
you must create the necessary token secret files:

```sh
# make sure token files exist
touch secrets/registration.token secrets/runner.token

# run one of the following
echo -n "<registration-token>" > secrets/registration.token
echo -n "<runner-token>" > secrets/runner.token
```

> **NOTE:** These files should not be checked into source control!
