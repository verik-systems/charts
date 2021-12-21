{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper application image name
*/}}
{{- define "application.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}


{{/*
Compile all warnings into a single message, and call fail.
*/}}
{{- define "application.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "application.validateValues.extraVolumes" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}

{{/* Validate values of application - Incorrect extra volume settings */}}
{{- define "application.validateValues.extraVolumes" -}}
{{- if and (.Values.extraVolumes) (not .Values.extraVolumeMounts) -}}
application: missing-extra-volume-mounts
    You specified extra volumes but not mount points for them. Please set
    the extraVolumeMounts value
{{- end -}}
{{- end -}}

{{/*
  Generate the .dockerconfigjson file unencoded.
*/}}
{{- define "dockerconfigjson.b64dec" }}
  {{- print "{\"auths\":{" }}
  {{- range $index, $item := .Values.image.credentials }}
    {{- if $index }}
      {{- print "," }}
    {{- end }}
    {{- printf "\"%s\":{\"auth\":\"%s\"}" (default "https://index.docker.io/v1/" $item.registry) (printf "%s:%s" $item.username $item.accessToken | b64enc) }}
  {{- end }}
  {{- print "}}" }}
{{- end }}

{{/*
  Generate the base64-encoded .dockerconfigjson.
  See https://github.com/helm/helm/issues/3691#issuecomment-386113346
*/}}
{{- define "dockerconfigjson.b64enc" }}
  {{- include "dockerconfigjson.b64dec" . | b64enc }}
{{- end }}