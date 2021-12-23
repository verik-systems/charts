
## VEriK Service Helm Chart

This chart bootstraps a VEriK cloud application deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## TL;DR
```
$ helm repo add verik-charts https://charts.veriksystems.com
$ helm install my-release verik-charts/verik-service
```

## Prerequisites

- Kubernetes 1.19+
- Helm 3.1.0
- PV provisioner support in the underlying infrastructure


## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release verik-charts/verik-service
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

| Name                                       | Description                                        | Value        |
| ------------------------------------------ | -------------------------------------------------- | ------------ |
| `commonLabels.app.kubernetes.io/name`      | common Kubernetes app label                        | `undefined`  |
| `commonLabels.app.kubernetes.io/component` | common Kubernetes app component                    | `undefined`  |
| `labels.app`                               | common app label                                   | `bull`       |
| `labels.role`                              | common role label                                  | `exporter`   |
| `labels.release`                           | allow prometheus scrape metrics                    | `prometheus` |
| `nameOverride`                             | String to partially override common.names.fullname | `""`         |


### Common Parameters

| Name                    | Description                                 | Value                     |
| ----------------------- | ------------------------------------------- | ------------------------- |
| `image.pullPolicy`      | pull image policy                           | `IfNotPresent`            |
| `image.registry`        | image registry                              | `registry.hub.docker.com` |
| `image.repository`      | image repository                            | `verik01/bull-exporter`   |
| `image.tag`             | image tag                                   | `v0.1.0`                  |
| `replicas`              | Number of Metrics Server replicas to deploy | `2`                       |
| `extraEnvVars[0].name`  | Extra environments name                     | `GET_HOSTS_FROM`          |
| `extraEnvVars[0].value` | Extra environments value                    | `dns`                     |
| `migrationArgs`         | command arg for migration script            | `["./migration"]`         |
| `configurations`        | configmap configuration data                | `[]`                      |


### Pod configuration Parameters

| Name                                 | Description                                        | Value                     |
| ------------------------------------ | -------------------------------------------------- | ------------------------- |
| `podAnnotations`                     | Additional pod annotations for MariaDB Galera pods | `{}`                      |
| `priorityClassName`                  | Priority class for pod scheduling                  | `system-cluster-critical` |
| `podAffinityPreset`                  | Pod affinity preset                                | `""`                      |
| `podAntiAffinityPreset`              | Pod anti-affinity preset                           | `soft`                    |
| `podDisruptionBudget.enabled`        | Pod disruption budget enabled                      | `false`                   |
| `podDisruptionBudget.minAvailable`   | Pod disruption budget min available pod            | `1`                       |
| `podDisruptionBudget.maxUnavailable` | Pod disruption budget max unavailable pod          | `3`                       |


### Node configuration Parameters

| Name                                          | Description                                              | Value       |
| --------------------------------------------- | -------------------------------------------------------- | ----------- |
| `nodeAffinityPreset.type`                     | Node affinity preset type                                | `""`        |
| `nodeAffinityPreset.key`                      | Node affinity preset key                                 | `""`        |
| `nodeAffinityPreset.values`                   | Node affinity preset values                              | `[]`        |
| `affinity`                                    | Affinity for pod assignment. Evaluated as a template.    | `{}`        |
| `nodeSelector.alpha.eksctl.io/nodegroup-name` | node group name for node selector                        | `undefined` |
| `tolerations`                                 | Tolerations for pod assignment. Evaluated as a template. | `[]`        |


### Storage configuration Parameters

| Name                             | Description                               | Value  |
| -------------------------------- | ----------------------------------------- | ------ |
| `extraVolumeMounts[0].name`      | extra volume mounts name                  | `tmp`  |
| `extraVolumeMounts[0].mountPath` | extra volume mounts path                  | `/tmp` |
| `extraVolumes[0].name`           | extra volume name                         | `tmp`  |
| `extraVolumes[0].emptyDir`       | extra volume emptyDir definition          | `{}`   |
| `extraArgs`                      | extra arguments pass to service container | `[]`   |


### Service configuration Parameters

| Name                          | Description                              | Value       |
| ----------------------------- | ---------------------------------------- | ----------- |
| `containerPort`               | Container port                           | `3000`      |
| `service.type`                | Kubernetes service type                  | `ClusterIP` |
| `service.labels`              | Kubernetes service labels                | `{}`        |
| `service.ports[0].name`       | Kubernetes service for http port         | `http`      |
| `service.ports[0].port`       | Kubernetes service port                  | `80`        |
| `service.ports[0].targetPort` | Kubernetes service target container port | `3000`      |
| `service.ports[1].name`       | Kubernetes service for metric port       | `metrics`   |
| `service.ports[1].port`       | Kubernetes service port                  | `9913`      |
| `service.ports[1].targetPort` | Kubernetes service target container port | `3000`      |
| `service.ports[1].protocol`   | Kubernetes service protocol is TCP       | `TCP`       |
| `service.ports[2].name`       | Kubernetes service for https port        | `https`     |
| `service.ports[2].port`       | Kubernetes service port                  | `443`       |
| `service.ports[2].targetPort` | Kubernetes service target container port | `3000`      |


### Ingress configuration Parameters

| Name                                              | Description                                                      | Value                      |
| ------------------------------------------------- | ---------------------------------------------------------------- | -------------------------- |
| `ingress.enabled`                                 | Kubernetes ingress enabled                                       | `false`                    |
| `ingress.annotations.kubernetes.io/ingress.class` | Kubernetes ingress annotations kubernetes.io/ingress.class nginx | `undefined`                |
| `ingress.labels`                                  | Kubernetes ingress labels                                        | `{}`                       |
| `ingress.port`                                    | Kubernetes ingress port                                          | `80`                       |
| `ingress.path`                                    | Kubernetes ingress path                                          | `/`                        |
| `ingress.pathType`                                | Kubernetes ingress pathType                                      | `Prefix`                   |
| `ingress.tls`                                     | Kubernetes ingress tls                                           | `[]`                       |
| `ingress.hosts`                                   | hosts list                                                       | `["app.veriksystems.com"]` |


### Resource quota configuraiton Parameters

| Name                        | Description                                    | Value   |
| --------------------------- | ---------------------------------------------- | ------- |
| `resources.limits.cpu`      | Kubernetes resources limit cpu configure       | `500m`  |
| `resources.limits.memory`   | Kubernetes resources limit memory configure    | `512Mi` |
| `resources.requests.cpu`    | Kubernetes resources requests cpu configure    | `250m`  |
| `resources.requests.memory` | Kubernetes resources requests memory configure | `256Mi` |


### Metric configuraiton Parameters

| Name                                       | Description                                                                                            | Value     |
| ------------------------------------------ | ------------------------------------------------------------------------------------------------------ | --------- |
| `metrics.enabled`                          | Enable the export of Prometheus metrics                                                                | `true`    |
| `metrics.serviceMonitor.enabled`           | if `true`, creates a Prometheus Operator ServiceMonitor (also requires `metrics.enabled` to be `true`) | `true`    |
| `metrics.serviceMonitor.namespace`         | Namespace in which Prometheus is running                                                               | `""`      |
| `metrics.serviceMonitor.interval`          | Interval at which metrics should be scraped.                                                           | `""`      |
| `metrics.serviceMonitor.scrapeTimeout`     | Timeout after which the scrape is ended                                                                | `""`      |
| `metrics.serviceMonitor.selector`          | Prometheus instance selector labels                                                                    | `{}`      |
| `metrics.serviceMonitor.metricRelabelings` | Specify Metric Relabellings to add to the scrape endpoint                                              | `[]`      |
| `metrics.serviceMonitor.honorLabels`       | Labels to honor to add to the scrape endpoint                                                          | `false`   |
| `metrics.serviceMonitor.additionalLabels`  | Additional custom labels for the ServiceMonitor                                                        | `{}`      |
| `metrics.serviceMonitor.jobLabel`          | The name of the label on the target service to use as the job name in prometheus.                      | `""`      |
| `metrics.serviceMonitor.port`              | service monitor port mapping with Kubernetes service endpoint port                                     | `metrics` |


### Resource Healthz configuraiton Parameters

| Name                     | Description                         | Value       |
| ------------------------ | ----------------------------------- | ----------- |
| `healthz.startupProbe`   | Kubernetes container startupProbe   | `/liveness` |
| `healthz.livenessProbe`  | Kubernetes container livenessProbe  | `/liveness` |
| `healthz.readinessProbe` | Kubernetes container readinessProbe | `/healthz`  |


