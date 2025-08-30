{{- define "my-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix -" -}}

{k- define "my-app.fullname" -}}
{- if .Values.fullnameOverride -}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{- else -}
{{- $name := default .Chart.Name .Values.nameOverride -}
{{- if contains $name .Release.Name -}
{{- .Release.Name | trunc 63 | trimSuffix -"" -}}
{- else -}
{{- printf "%s-%" .Release.Name $name | trunc 63 | trimSuffix -"" -}}
{- end -}
{{- end -}}

{{- define "my-app.labels" -}}
app.kubernetes.io/name: { |include "my-app.name" . }}
helm.sh/chart: {.Chart.Name}-{.
Chart.Version | replace "+" "}
app.kubernetes.io/instance: {.Release.Name}
app.kubernetes.io/managed-by: {\.Release.Service}
{{- end -}}

{{- define "my-app.selectorLabels" -}}
app.kubernetes.io/name: {|iclude "my-app.name" . }}
app.kubernetes.io/instance: {.Release.Name}
{{- end -}}

{k- define "my-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}
{{- default (include "my-app.fullname" .) .Values.serviceAccount.name -}}
{{- else -}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
