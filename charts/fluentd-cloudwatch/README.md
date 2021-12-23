
## AWS CloudWatch Logs Agent Helm Chart

This chart bootstraps a AWS CloudWatch Logs Agent with fluentd deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## TL;DR
```
$ helm repo add verik-charts https://charts.veriksystems.com
$ helm install my-release verik-charts/fluentd-cloudwatch
```

## Prerequisites

- Kubernetes 1.19+
- Helm 3.1.0
- PV provisioner support in the underlying infrastructure


## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release verik-charts/fluentd-cloudwatch
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

| Name                                 | Description                           | Value                               |
| ------------------------------------ | ------------------------------------- | ----------------------------------- |
| `labels.app`                         | common app label                      | `fluentd-cloudwatch`                |
| `labels.app.kubernetes.io/name`      | common Kubernetes app label           | `undefined`                         |
| `labels.app.kubernetes.io/component` | common Kubernetes app component label | `undefined`                         |
| `labels.k8s-app`                     | another k8s app name                  | `fluentd-cloudwatch`                |
| `serviceAccount.name`                | service account name                  | `fluentd`                           |
| `clusterRole.rules[0].apiGroups`     | api groups rules                      | `[""]`                              |
| `clusterRole.rules[0].resources`     | resources is applied                  | `["namespaces","pods","pods/logs"]` |
| `clusterRole.rules[0].verbs`         | resources verbs is applied            | `["get","list","watch"]`            |


### Resource quota configuraiton Parameters

| Name                        | Description                                    | Value   |
| --------------------------- | ---------------------------------------------- | ------- |
| `resources.limits.cpu`      | Kubernetes resources limit cpu configure       | `100m`  |
| `resources.limits.memory`   | Kubernetes resources limit memory configure    | `512Mi` |
| `resources.requests.cpu`    | Kubernetes resources requests cpu configure    | `100m`  |
| `resources.requests.memory` | Kubernetes resources requests memory configure | `256Mi` |


### configuraiton Parameters

| Name                                 | Description       | Value                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| ------------------------------------ | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `daemonSet.annotations.configHash`   | config hash       | `8915de4cf9c3551a8dc74c0137a3e83569d28c71044b0359c2578d2e0461825`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| `configMap.clusterInfo.cluster.name` | cluster name      | `undefined`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `configMap.clusterInfo.logs.region`  | region logs       | `undefined`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `configMap.data.fluentConfig`        | config of fluentd | `@include containers.conf
@include systemd.conf
@include host.conf

<match fluent.**>
  @type null
</match>
`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| `configMap.data.containerConfig`     | config of fluentd | `<source>
  @type tail
  @id in_tail_container_logs
  @label @containers
  path /var/log/containers/*.log
  exclude_path ["/var/log/containers/cloudwatch-agent*", "/var/log/containers/fluentd*"]
  pos_file /var/log/fluentd-containers.log.pos
  tag *
  read_from_head true
  <parse>
    @type json
    time_format %Y-%m-%dT%H:%M:%S.%NZ
  </parse>
</source>

<source>
  @type tail
  @id in_tail_cwagent_logs
  @label @cwagentlogs
  path /var/log/containers/cloudwatch-agent*
  pos_file /var/log/cloudwatch-agent.log.pos
  tag *
  read_from_head true
  <parse>
    @type json
    time_format %Y-%m-%dT%H:%M:%S.%NZ
  </parse>
</source>

<source>
  @type tail
  @id in_tail_fluentd_logs
  @label @fluentdlogs
  path /var/log/containers/fluentd*
  pos_file /var/log/fluentd.log.pos
  tag *
  read_from_head true
  <parse>
    @type json
    time_format %Y-%m-%dT%H:%M:%S.%NZ
  </parse>
</source>

<label @fluentdlogs>
  <filter **>
    @type kubernetes_metadata
    @id filter_kube_metadata_fluentd
  </filter>

  <filter **>
    @type record_transformer
    @id filter_fluentd_stream_transformer
    <record>
      stream_name ${tag_parts[3]}
    </record>
    remove_keys $.kubernetes.pod_id, $.kubernetes.master_url, $.kubernetes.container_image_id, $.kubernetes.namespace_id
  </filter>

  <match **>
    @type relabel
    @label @NORMAL
  </match>
</label>

<label @containers>
  <filter **>
    @type kubernetes_metadata
    @id filter_kube_metadata
  </filter>

  <filter **>
    @type record_transformer
    @id filter_containers_stream_transformer
    <record>
      stream_name ${tag_parts[3]}
    </record>
    remove_keys $.kubernetes.pod_id, $.kubernetes.master_url, $.kubernetes.container_image_id, $.kubernetes.namespace_id
  </filter>

  <filter **>
    @type concat
    key log
    multiline_start_regexp /^\S/
    separator ""
    flush_interval 5
    timeout_label @NORMAL
  </filter>

  <match **>
    @type relabel
    @label @NORMAL
  </match>
</label>

<label @cwagentlogs>
  <filter **>
    @type kubernetes_metadata
    @id filter_kube_metadata_cwagent
  </filter>

  <filter **>
    @type record_transformer
    @id filter_cwagent_stream_transformer
    <record>
      stream_name ${tag_parts[3]}
    </record>
    remove_keys $.kubernetes.pod_id, $.kubernetes.master_url, $.kubernetes.container_image_id, $.kubernetes.namespace_id
  </filter>

  <filter **>
    @type concat
    key log
    multiline_start_regexp /^\d{4}[-/]\d{1,2}[-/]\d{1,2}/
    separator ""
    flush_interval 5
    timeout_label @NORMAL
  </filter>

  <match **>
    @type relabel
    @label @NORMAL
  </match>
</label>

<label @NORMAL>
  <match **>
    @type cloudwatch_logs
    @id out_cloudwatch_logs_containers
    region "#{ENV.fetch('REGION')}"
    log_group_name "/aws/containerinsights/#{ENV.fetch('CLUSTER_NAME')}/application"
    log_stream_name_key stream_name
    remove_log_stream_name_key true
    auto_create_stream true
    <buffer>
      flush_interval 5
      chunk_limit_size 2m
      queued_chunks_limit_size 32
      retry_forever true
    </buffer>
  </match>
</label>
` |
| `configMap.data.systemd.conf`        | config of fluentd | `undefined`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `configMap.data.host.conf`           | config of fluentd | `undefined`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |


