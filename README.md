# doku cluster management KPT Packages

This repository contains common/shared applications installed in my personal kubernetes cluster. The resources
here are managed with `kpt`.

The main components are:

- cert-manager
- ingress-nginx
- mongodb-kubernetes-operator

This repository lets me use Git-Ops to manage my cluster. I'm using a few configuration options that prevent provisioning clusters other than on Digitalocean, for instance: external load balancer options with ingress-nginx, and my letsencrypt issuer with cert-manager.


<details>
<summary>Full KPT resource list</summary>

```
Package "doku-cluster-mgmt"
├── [Kptfile]  Kptfile doku-cluster-mgmt
├── [starlark-kustomize-local-config.yaml]  StarlarkRun add-local-config-annotation
├── [starlark-remove-helm.yaml]  StarlarkRun remove-managed-by-helm
├── Package "cert-manager"
│   ├── [Kptfile]  Kptfile cert-manager
│   ├── secrets
│   │   └── [account-key.secret.yaml]  Secret cert-manager/letsencrypt-account-key
│   ├── default-issuer
│   │   └── [cluster-issuer.yaml]  ClusterIssuer letsencrypt
│   ├── secrets
│   │   └── [digitalocean-dns.secret.yaml]  Secret cert-manager/digitalocean-dns
│   ├── self-signed-issuer
│   │   └── [ca-issuer.yaml]  ClusterIssuer ca-issuer
│   ├── secrets
│   │   └── [ca-key.secret.yaml]  Secret cert-manager/ca-key-pair
│   ├── Package "upstream"
│   │   ├── [Kptfile]  Kptfile cert-manager
│   │   ├── [clusterrole_cert-manager-cainjector.yaml]  ClusterRole cert-manager-cainjector
│   │   ├── [clusterrole_cert-manager-controller-approve:cert-manager-io.yaml]  ClusterRole cert-manager-controller-approve:cert-manager-io
│   │   ├── [clusterrole_cert-manager-controller-certificates.yaml]  ClusterRole cert-manager-controller-certificates
│   │   ├── [clusterrole_cert-manager-controller-certificatesigningrequests.yaml]  ClusterRole cert-manager-controller-certificatesigningrequests
│   │   ├── [clusterrole_cert-manager-controller-challenges.yaml]  ClusterRole cert-manager-controller-challenges
│   │   ├── [clusterrole_cert-manager-controller-clusterissuers.yaml]  ClusterRole cert-manager-controller-clusterissuers
│   │   ├── [clusterrole_cert-manager-controller-ingress-shim.yaml]  ClusterRole cert-manager-controller-ingress-shim
│   │   ├── [clusterrole_cert-manager-controller-issuers.yaml]  ClusterRole cert-manager-controller-issuers
│   │   ├── [clusterrole_cert-manager-controller-orders.yaml]  ClusterRole cert-manager-controller-orders
│   │   ├── [clusterrole_cert-manager-edit.yaml]  ClusterRole cert-manager-edit
│   │   ├── [clusterrole_cert-manager-view.yaml]  ClusterRole cert-manager-view
│   │   ├── [clusterrole_cert-manager-webhook:subjectaccessreviews.yaml]  ClusterRole cert-manager-webhook:subjectaccessreviews
│   │   ├── [clusterrolebinding_cert-manager-cainjector.yaml]  ClusterRoleBinding cert-manager-cainjector
│   │   ├── [clusterrolebinding_cert-manager-controller-approve:cert-manager-io.yaml]  ClusterRoleBinding cert-manager-controller-approve:cert-manager-io
│   │   ├── [clusterrolebinding_cert-manager-controller-certificates.yaml]  ClusterRoleBinding cert-manager-controller-certificates
│   │   ├── [clusterrolebinding_cert-manager-controller-certificatesigningrequests.yaml]  ClusterRoleBinding cert-manager-controller-certificatesigningrequests
│   │   ├── [clusterrolebinding_cert-manager-controller-challenges.yaml]  ClusterRoleBinding cert-manager-controller-challenges
│   │   ├── [clusterrolebinding_cert-manager-controller-clusterissuers.yaml]  ClusterRoleBinding cert-manager-controller-clusterissuers
│   │   ├── [clusterrolebinding_cert-manager-controller-ingress-shim.yaml]  ClusterRoleBinding cert-manager-controller-ingress-shim
│   │   ├── [clusterrolebinding_cert-manager-controller-issuers.yaml]  ClusterRoleBinding cert-manager-controller-issuers
│   │   ├── [clusterrolebinding_cert-manager-controller-orders.yaml]  ClusterRoleBinding cert-manager-controller-orders
│   │   ├── [clusterrolebinding_cert-manager-webhook:subjectaccessreviews.yaml]  ClusterRoleBinding cert-manager-webhook:subjectaccessreviews
│   │   ├── [mutatingwebhookconfiguration_cert-manager-webhook.yaml]  MutatingWebhookConfiguration cert-manager-webhook
│   │   ├── [validatingwebhookconfiguration_cert-manager-webhook.yaml]  ValidatingWebhookConfiguration cert-manager-webhook
│   │   └── kube-system
│   │       ├── [role_cert-manager-cainjector:leaderelection.yaml]  Role kube-system/cert-manager-cainjector:leaderelection
│   │       ├── [role_cert-manager:leaderelection.yaml]  Role kube-system/cert-manager:leaderelection
│   │       ├── [rolebinding_cert-manager-cainjector:leaderelection.yaml]  RoleBinding kube-system/cert-manager-cainjector:leaderelection
│   │       └── [rolebinding_cert-manager:leaderelection.yaml]  RoleBinding kube-system/cert-manager:leaderelection
│   └── cert-manager
│       ├── [deployment_cert-manager-cainjector.yaml]  Deployment cert-manager/cert-manager-cainjector
│       ├── [deployment_cert-manager-webhook.yaml]  Deployment cert-manager/cert-manager-webhook
│       ├── [deployment_cert-manager.yaml]  Deployment cert-manager/cert-manager
│       ├── [job_cert-manager-startupapicheck.yaml]  Job cert-manager/cert-manager-startupapicheck
│       ├── [role_cert-manager-startupapicheck:create-cert.yaml]  Role cert-manager/cert-manager-startupapicheck:create-cert
│       ├── [role_cert-manager-webhook:dynamic-serving.yaml]  Role cert-manager/cert-manager-webhook:dynamic-serving
│       ├── [rolebinding_cert-manager-startupapicheck:create-cert.yaml]  RoleBinding cert-manager/cert-manager-startupapicheck:create-cert
│       ├── [rolebinding_cert-manager-webhook:dynamic-serving.yaml]  RoleBinding cert-manager/cert-manager-webhook:dynamic-serving
│       ├── [service_cert-manager-webhook.yaml]  Service cert-manager/cert-manager-webhook
│       ├── [service_cert-manager.yaml]  Service cert-manager/cert-manager
│       ├── [serviceaccount_cert-manager-cainjector.yaml]  ServiceAccount cert-manager/cert-manager-cainjector
│       ├── [serviceaccount_cert-manager-startupapicheck.yaml]  ServiceAccount cert-manager/cert-manager-startupapicheck
│       ├── [serviceaccount_cert-manager-webhook.yaml]  ServiceAccount cert-manager/cert-manager-webhook
│       └── [serviceaccount_cert-manager.yaml]  ServiceAccount cert-manager/cert-manager
├── Package "ingress-nginx"
│   ├── [Kptfile]  Kptfile ingress-nginx
│   ├── [custom-headers.configmap.yaml]  ConfigMap ingress-nginx/ingress-nginx-custom-headers
│   ├── [namespace.yaml]  Namespace ingress-nginx
│   ├── secrets
│   │   └── [account.secret.yaml]  Secret ingress-nginx/ingress-nginx-maxmind-license
│   └── Package "upstream"
│       ├── [Kptfile]  Kptfile ingress-nginx
│       ├── [clusterrole_ingress-nginx-admission.yaml]  ClusterRole ingress-nginx-admission
│       ├── [clusterrole_ingress-nginx.yaml]  ClusterRole ingress-nginx
│       ├── [clusterrolebinding_ingress-nginx-admission.yaml]  ClusterRoleBinding ingress-nginx-admission
│       ├── [clusterrolebinding_ingress-nginx.yaml]  ClusterRoleBinding ingress-nginx
│       ├── [ingressclass_nginx.yaml]  IngressClass nginx
│       ├── [validatingwebhookconfiguration_ingress-nginx-admission.yaml]  ValidatingWebhookConfiguration ingress-nginx-admission
│       └── ingress-nginx
│           ├── [configmap_ingress-nginx-controller.yaml]  ConfigMap ingress-nginx/ingress-nginx-controller
│           ├── [deployment_ingress-nginx-controller.yaml]  Deployment ingress-nginx/ingress-nginx-controller
│           ├── [job_ingress-nginx-admission-create.yaml]  Job ingress-nginx/ingress-nginx-admission-create
│           ├── [job_ingress-nginx-admission-patch.yaml]  Job ingress-nginx/ingress-nginx-admission-patch
│           ├── [role_ingress-nginx-admission.yaml]  Role ingress-nginx/ingress-nginx-admission
│           ├── [role_ingress-nginx.yaml]  Role ingress-nginx/ingress-nginx
│           ├── [rolebinding_ingress-nginx-admission.yaml]  RoleBinding ingress-nginx/ingress-nginx-admission
│           ├── [rolebinding_ingress-nginx.yaml]  RoleBinding ingress-nginx/ingress-nginx
│           ├── [service_ingress-nginx-controller-admission.yaml]  Service ingress-nginx/ingress-nginx-controller-admission
│           ├── [service_ingress-nginx-controller.yaml]  Service ingress-nginx/ingress-nginx-controller
│           ├── [serviceaccount_ingress-nginx-admission.yaml]  ServiceAccount ingress-nginx/ingress-nginx-admission
│           └── [serviceaccount_ingress-nginx.yaml]  ServiceAccount ingress-nginx/ingress-nginx
└── Package "mongodb-kubernetes-operator"
    ├── [Kptfile]  Kptfile mongodb-kubernetes-operator
    ├── Package "bases"
    │   ├── [Kptfile]  Kptfile bases
    │   └── [mongodbcommunity.mongodb.com_mongodbcommunity.yaml]  CustomResourceDefinition mongodbcommunity.mongodbcommunity.mongodb.com
    ├── Package "manager"
    │   ├── [Kptfile]  Kptfile manager
    │   └── [manager.yaml]  Deployment mongodb-operator/mongodb-kubernetes-operator
    ├── Package "rbac"
    │   ├── [Kptfile]  Kptfile rbac
    │   ├── [role.yaml]  Role mongodb-operator/mongodb-kubernetes-operator
    │   ├── [role_binding.yaml]  RoleBinding mongodb-operator/mongodb-kubernetes-operator
    │   └── [service_account.yaml]  ServiceAccount mongodb-operator/mongodb-kubernetes-operator
    └── Package "clusterwide"
        ├── [Kptfile]  Kptfile clusterwide
        ├── [role.yaml]  ClusterRole mongodb-kubernetes-operator
        └── [role_binding.yaml]  ClusterRoleBinding mongodb-kubernetes-operator
```

</details>


Forked originally from [NASA's Johnson Space Center's KPT-packages](https://appdat.jsc.nasa.gov/appdat/kpt-packages/) repository, updated to use `kpt fn render-helm-chart`, less `kustomize`, and without support for some packages I didn't need.
