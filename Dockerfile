ARG SEMAPHORE_VERSION=v2.19.8
FROM semaphoreui/semaphore:${SEMAPHORE_VERSION}

ARG KUBECTL_VERSION=v1.35.2
ARG TALOSCTL_VERSION=v1.13.4
ARG TARGETARCH=amd64

USER root

RUN apk add --no-cache curl ca-certificates py3-pip \
    && curl -fsSL -o /usr/local/bin/kubectl \
         "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl" \
    && curl -fsSL -o /usr/local/bin/talosctl \
         "https://github.com/siderolabs/talos/releases/download/${TALOSCTL_VERSION}/talosctl-linux-${TARGETARCH}" \
    && chmod +x /usr/local/bin/kubectl /usr/local/bin/talosctl \
    && kubectl version --client \
    && talosctl version --client \
    && pip install --no-cache-dir --break-system-packages kubernetes \
    && ansible-galaxy collection install kubernetes.core ansible.posix community.general

ENV KUBECONFIG=/etc/semaphore/secrets/kubeconfig
ENV TALOSCONFIG=/etc/semaphore/secrets/talosconfig

USER 1001:0