
## VEriK Service Helm Chart

This chart bootstraps a VEriK cloud application deployment (https://charts.veriksystems.com) on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

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

| Name                                       | Description                                        | Value           |
| ------------------------------------------ | -------------------------------------------------- | --------------- |
| `commonLabels.app.kubernetes.io/name`      | common Kubernetes app label                        | `undefined`     |
| `commonLabels.app.kubernetes.io/component` | common Kubernetes app component                    | `undefined`     |
| `labels.app`                               | common app label                                   | `verik-service` |
| `labels.role`                              | common role label                                  | `worker`        |
| `labels.release`                           | allow prometheus scrape metrics                    | `prometheus`    |
| `nameOverride`                             | String to partially override common.names.fullname | `""`            |


### Common Parameters

| Name                      | Description                                 | Value                     |
| ------------------------- | ------------------------------------------- | ------------------------- |
| `image.pullPolicy`        | pull image policy                           | `IfNotPresent`            |
| `image.registry`          | image registry                              | `registry.hub.docker.com` |
| `image.repository`        | image repository                            | `busybox`                 |
| `image.tag`               | image tag                                   | `stable`                  |
| `replicas`                | Number of Metrics Server replicas to deploy | `2`                       |
| `defaultEnvVars`          | default environments                        | `[]`                      |
| `extraEnvVars`            | Extra environments                          | `[]`                      |
| `inputEnvVars`            | input environments                          | `[]`                      |
| `migration.enabled`       | migration script enabled                    | `false`                   |
| `migration.skip`          | migration script skip                       | `true`                    |
| `migration.migrationArgs` | command arg for migration script            | `["./migration"]`         |
| `configurations`          | configmap configuration data                | `[]`                      |


### Pod configuration Parameters

| Name                                                  | Description                                 | Value                     |
| ----------------------------------------------------- | ------------------------------------------- | ------------------------- |
| `podAnnotations.sidecar.istio.io/proxyRequestsCPU`    | istio sidecar container resource definition | `undefined`               |
| `podAnnotations.sidecar.istio.io/proxyRequestsMemory` | istio sidecar container resource definition | `undefined`               |
| `podAnnotations.sidecar.istio.io/proxyLimitsCPU`      | istio sidecar container resource definition | `undefined`               |
| `podAnnotations.sidecar.istio.io/proxyLimitsMemory`   | istio sidecar container resource definition | `undefined`               |
| `priorityClassName`                                   | Priority class for pod scheduling           | `system-cluster-critical` |
| `podAffinityPreset`                                   | Pod affinity preset                         | `""`                      |
| `podAntiAffinityPreset`                               | Pod anti-affinity preset                    | `soft`                    |
| `podDisruptionBudget.enabled`                         | Pod disruption budget enabled               | `false`                   |
| `podDisruptionBudget.minAvailable`                    | Pod disruption budget min available pod     | `1`                       |
| `podDisruptionBudget.maxUnavailable`                  | Pod disruption budget max unavailable pod   | `3`                       |


### Node configuration Parameters

| Name                        | Description                                              | Value |
| --------------------------- | -------------------------------------------------------- | ----- |
| `nodeAffinityPreset.type`   | Node affinity preset type                                | `""`  |
| `nodeAffinityPreset.key`    | Node affinity preset key                                 | `""`  |
| `nodeAffinityPreset.values` | Node affinity preset values                              | `[]`  |
| `affinity`                  | Affinity for pod assignment. Evaluated as a template.    | `{}`  |
| `nodeSelector`              | node group name for node selector                        | `{}`  |
| `tolerations`               | Tolerations for pod assignment. Evaluated as a template. | `[]`  |


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
| `ingress.enabled`                                 | Kubernetes ingress enabled                                       | `true`                     |
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
| `resources.limits.cpu`      | Kubernetes resources limit cpu configure       | `250m`  |
| `resources.limits.memory`   | Kubernetes resources limit memory configure    | `512Mi` |
| `resources.requests.cpu`    | Kubernetes resources requests cpu configure    | `100m`  |
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


### Resource Scaling configuraiton Parameters

| Name                                | Description                                                                                                                                                                                                                                                                                                                                                                                                                                       | Value                                      |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------ |
| `autoscaling.enabled`               | enable/disable KEDA scale based on SQS metrics                                                                                                                                                                                                                                                                                                                                                                                                    | `true`                                     |
| `autoscaling.AWS_ACCESS_KEY_ID`     | aws_access_key_id                                                                                                                                                                                                                                                                                                                                                                                                                                 | `please update your aws_access_key_id`     |
| `autoscaling.AWS_SECRET_ACCESS_KEY` | aws_secret_access_key                                                                                                                                                                                                                                                                                                                                                                                                                             | `please update your aws_secret_access_key` |
| `autoscaling.mode`                  | resource|queue. autoscaling by resource(cpu, memory) or queue length.                                                                                                                                                                                                                                                                                                                                                                             | `resource`                                 |
| `autoscaling.policy.queueURL`       | queueURL - Full URL for the SQS Queue.                                                                                                                                                                                                                                                                                                                                                                                                            | `SQS queue name`                           |
| `autoscaling.policy.queueLength`    | - Target value for queue length passed to the scaler. Example: if one pod can handle 10 messages, set the queue length target to 10. If the actual messages in the SQS Queue is 30, the scaler scales to 3 pods. (default: 5). For the purposes of autoscaling, “actual messages” is equal to ApproximateNumberOfMessages + ApproximateNumberOfMessagesNotVislble, since NotVisible in SQS terms means the message is still in-flight/processing. | `5`                                        |
| `autoscaling.policy.awsRegion`      | - AWS Region for the SQS Queue.                                                                                                                                                                                                                                                                                                                                                                                                                   | `us-east-1`                                |
| `autoscaling.policy.minReplicas`    | - min relpicas                                                                                                                                                                                                                                                                                                                                                                                                                                    | `1`                                        |
| `autoscaling.policy.maxReplicas`    | - max relpicas                                                                                                                                                                                                                                                                                                                                                                                                                                    | `10`                                       |
| `autoscaling.policy.targetCPU`      | - cpu percent threshold                                                                                                                                                                                                                                                                                                                                                                                                                           | `40`                                       |
| `autoscaling.policy.targetMemory`   | - Memory percent threshold                                                                                                                                                                                                                                                                                                                                                                                                                        | `80`                                       |


### Security Context Parameters

| Name                                     | Description                      | Value  |
| ---------------------------------------- | -------------------------------- | ------ |
| `securityContext.readOnlyRootFilesystem` | - set file system is readonly    | `true` |
| `securityContext.runAsNonRoot`           | - run as a noon root user        | `true` |
| `securityContext.runAsUser`              | - run as a specific user by rule | `1000` |


