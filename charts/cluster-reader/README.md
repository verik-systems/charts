
## Cluster Readonly Account Helm Chart

This chart bootstraps a Cluster Readonly Account deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## TL;DR
```
$ helm repo add verik-charts https://charts.veriksystems.com
$ helm install my-release verik-charts/cluster-reader
```

## Prerequisites

- Kubernetes 1.19+
- Helm 3.1.0
- PV provisioner support in the underlying infrastructure


## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release verik-charts/cluster-reader
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

| Name                                       | Description                           | Value                    |
| ------------------------------------------ | ------------------------------------- | ------------------------ |
| `commonLabels.app`                         | common app label                      | `cluster-reader`         |
| `commonLabels.app.kubernetes.io/name`      | common Kubernetes app label           | `undefined`              |
| `commonLabels.app.kubernetes.io/component` | common Kubernetes app component label | `undefined`              |
| `serviceAccount.name`                      | name of service account               | `cluster-reader`         |
| `clusterRole.rules[0].apiGroups`           | api groups rules                      | `["*"]`                  |
| `clusterRole.rules[0].resources`           | resources is applied                  | `["*"]`                  |
| `clusterRole.rules[0].verbs`               | resources verbs is applied            | `["get","list","watch"]` |
| `clusterRole.rules[1].apiGroups`           | api groups rules                      | `[""]`                   |
| `clusterRole.rules[1].resources`           | resources is applied                  | `["pods/portforward"]`   |
| `clusterRole.rules[1].verbs`               | resources verbs is applied            | `["create"]`             |


