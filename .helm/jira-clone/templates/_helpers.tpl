

{{- define "jira-clone.image" -}}
"{{ .Values.container.image.repository }}:{{ .Values.container.image.tag | default .Chart.AppVersion }}"  
{{- end -}}

{{- define "jira-clone.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "jira-clone.fullname" -}}
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

{{- define "jira-clone.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "jira-clone.labels" -}}
helm.sh/chart: {{ include "jira-clone.chart" . }}
{{ include "jira-clone.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "jira-clone.selectorLabels" -}}
app.kubernetes.io/name: {{ include "jira-clone.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "jira-clone.database-fullname" -}}
{{ include "jira-clone.fullname" .Subcharts.postgresql }}
{{- end -}}

{{- define "jira-clone.upstash-fullname" -}}
{{ include "jira-clone.fullname" .Subcharts.upstash }}
{{- end -}}

{{- define "jira-clone.upstash-url" -}}
"http://{{ include "jira-clone.upstash-fullname" . }}:{{ .Values.upstash.port }}"
{{- end -}}