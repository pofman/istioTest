{{/*
Expand the name of the chart.
*/}}
{{- define "my-weather-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "my-weather-app.api" -}}
{{- printf "%s-api" .Values.apiName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "my-weather-app.gateway" -}}
{{- printf "%s-gateway" .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "my-weather-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "my-weather-app.appfqdn" -}}
{{- printf "%s.default.svc.cluster.local" (include "my-weather-app.fullname" .) -}}
{{- end}}

{{- define "my-weather-app.apifullname" -}}
{{- $name := .Values.apiName | trunc 63 | trimSuffix "-" }}
{{- if contains $name .Release.Name }}
{{- printf "%s-api" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s-api" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "my-weather-app.apifqdn" -}}
{{- printf "%s.default.svc.cluster.local" (include "my-weather-app.apifullname" .) -}}
{{- end}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "my-weather-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "my-weather-app.labels" -}}
helm.sh/chart: {{ include "my-weather-app.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "my-weather-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "my-weather-app.name" . }}
app.kubernetes.io/instance: {{ printf "%s-app" .Release.Name }}
{{- end }}

{{- define "my-weather-app.apiselectorLabels" -}}
app.kubernetes.io/name: {{ include "my-weather-app.api" . }}
app.kubernetes.io/instance: {{ printf "%s-api" .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "my-weather-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "my-weather-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
