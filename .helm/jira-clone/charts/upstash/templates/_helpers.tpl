{{- define "upstash.redis.url" -}}
"redis://{{ .Values.redis.hostname }}:{{ .Values.redis.port }}"
{{- end -}} 

{{- define "upstash.image" -}}
"{{ .image }}:{{ .tag | default "latest" }}"  
{{- end -}}

{{- define "upstash.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "upstash.fullname" -}}
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

{{- define "upstash.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "upstash.labels" -}}
helm.sh/chart: {{ include "upstash.chart" . }}
{{ include "upstash.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "upstash.selectorLabels" -}}
app.kubernetes.io/name: {{ include "upstash.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}