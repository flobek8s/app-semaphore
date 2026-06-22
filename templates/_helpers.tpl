{{- define "semaphore.fullname" -}}
semaphore
{{- end -}}

{{- define "semaphore.labels" -}}
app.kubernetes.io/name: semaphore
app.kubernetes.io/instance: {{ include "semaphore.fullname" . }}
{{- end -}}

{{- define "semaphore.selectorLabels" -}}
app.kubernetes.io/name: semaphore
{{- end -}}