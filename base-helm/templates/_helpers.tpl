{{/*
Common labels
*/}}
{{- define "common.labels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: {{ .Chart.Name }}
{{- end }}

{{/*
Common environment variables
*/}}
{{- define "common.envVars" -}}
- name: "CLIENT_ORIGIN_URL"
  value: "{{ .Values.host }}"
- name: "ALLOWED_CORS_ORIGIN"
  value: "https://{{ .Values.host }}"
{{- if .Values.backend.enabled }}
- name: "BACKEND_ORIGIN_URL"
  value: "{{ .Values.host }}/api"
- name: "API_ENDPOINT_PORT"
  value: "{{ .Values.backend.port }}"
{{- end -}}
{{- if .Values.database.enabled }}
- name: "POSTGRES_HOSTNAME"
  value: {{ .Values.database.name | default .Chart.Name }}
- name: "POSTGRES_PORT"
  value: {{ .Values.database.port }}
- name: "POSTGRES_USER"
  value: {{ .Values.database.user }}
- name: "POSTGRES_PASSWORD"
  value: {{ .Values.database.password }}
- name: "POSTGRES_DB_NAME"
  value: {{ .Values.database.password }}
{{- end -}}
{{- end }}