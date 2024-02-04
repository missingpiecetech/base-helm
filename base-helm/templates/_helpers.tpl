{{/*
Common labels
*/}}
{{- define "common.labels" -}}
helm.sh/chart: {{ include "base-helm.chart" . }}
{{ include "base-helm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: {{ include "base-helm.fullname" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "base-helm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "base-helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
