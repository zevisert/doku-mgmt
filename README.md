# APPDAT KPT Packages

## Contributing

### Upgrading Packages

```sh
scripts/update.sh <package> <version>

# examples:

scripts/update.sh cert-manager 1.3.0
scripts/update.sh elastic-cloud 1.6.0
scripts/update.sh ingress-nginx 0.45.0
```

<!-- TODO: following doc is irrelevant until we switch back to using agentk

## Building Your Agent Config Project

```sh
export GROUP="example"
export AGENT_NAME="my-agent"
```

1. initialize agent config repo

```sh
mkdir -p "$GROUP/cluster-config"
cd "$GROUP/cluster-config"

git init

# create agent config file
mkdir -p ".gitlab/agents/$AGENT_NAME"
cat <<EOF > ".gitlab/agents/$AGENT_NAME"
gitops:
  manifest_projects:
  - id: $GROUP/cluster-config
    paths:
    - glob: '/manifests/**/*.yaml'
EOF
```

2. add kpt packages you wish to use (see [`kpt pkg get` docs](https://googlecontainertools.github.io/kpt/reference/pkg/get/))

```sh
kpt pkg get git@appdat.jsc.nasa.gov:appdat/kpt-packages.git/ingress-nginx@master ingress-nginx
kpt pkg get git@appdat.jsc.nasa.gov:appdat/kpt-packages.git/cert-manager@master cert-manager
```

3. create a `kustomization.yaml` file

```sh
cat <<EOF > kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- ingress-nginx/appdat
- cert-manager/appdat
EOF
```

4. generate manifest files and checkin

```sh
mkdir manifests
kustomize build . -o manifests

git add .
git commit -m "initial commit"
git push
```

## Deploying Your Agent

1. [follow these instructions](https://docs.gitlab.com/ee/user/clusters/agent/#create-an-agent-record-in-gitlab) to generate an agent token
1. deploy an agent to the cluster using the generated token:

```sh
kubectl create namespace gitlab-agent
docker run --rm -it registry.gitlab.com/gitlab-org/cluster-integration/gitlab-agent/cli:latest generate \
  --agent-token "<agent-token>" \
  --agent-version "<agent-version>" \
  --namespace "gitlab-agent" \
  --kas-address wss://kas.appdat.jsc.nasa.gov:443 | kubectl apply -f -
```

1. verify that everything is working by tailing agent logs:

```sh
kubectl logs -f -l=app=gitlab-agent -n gitlab-agent
```

## Modifying the Package Defaults

Various setters are exposed for basic customizations of the manifets provided in this project.
See the [`kpt cfg set`](https://googlecontainertools.github.io/kpt/reference/cfg/set/) docs for usage.

When the setters do not provide enough flexibility you are free to override anything in the individual
manifest files directly. Even after manual modifications are made you can still pull in upstream changes
using [`kpt pkg update`](https://googlecontainertools.github.io/kpt/reference/pkg/update/). For example:

```sh
kpt pkg update cert-manager@master --strategy=resource-merge
```
-->
