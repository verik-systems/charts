
## Prometheus federation for leaf node Account Helm Chart

This chart bootstraps a Prometheus federation for leaf node Account deployment on a [Kubernetes](https://kubernetes.io) Namespace using the [Helm](https://helm.sh) package manager.

## TL;DR
```
$ helm repo add verik-charts https://charts.veriksystems.com
$ helm install my-release verik-charts/prometheus-federation
```

## Prerequisites

- Kubernetes 1.19+
- Helm 3.1.0
- PV provisioner support in the underlying infrastructure


## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release verik-charts/prometheus-federation
```

The command deploys Redmine on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.


## Parameters

### Global Parameters

| Name                                       | Description                           | Value                                                 |
| ------------------------------------------ | ------------------------------------- | ----------------------------------------------------- |
| `commonLabels.app`                         | common app label                      | `prometheus`                                          |
| `commonLabels.app.kubernetes.io/name`      | common Kubernetes app label           | `undefined`                                           |
| `commonLabels.app.kubernetes.io/component` | common Kubernetes app component label | `undefined`                                           |
| `serviceAccount.name`                      | name of service account               | `prometheus-federation`                               |
| `role.rules[0].apiGroups`                  | api groups rules                      | `[""]`                                                |
| `role.rules[0].resources`                  | resources is applied                  | `["services/proxy"]`                                  |
| `role.rules[0].resourceNames`              | resource name                         | `["http:prometheus-kube-prometheus-prometheus:9090"]` |
| `role.rules[0].verbs`                      | resources verbs is applied            | `["get"]`                                             |


