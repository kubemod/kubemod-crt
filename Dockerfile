FROM alpine:3.6

ARG NONROOT_UID=65532
ARG NONROOT_GID=65532

ADD https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 /usr/local/bin/cfssl
ADD https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 /usr/local/bin/cfssljson
ADD https://storage.googleapis.com/kubernetes-release/release/v1.19.0/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN chmod +x \
    /usr/local/bin/cfssl \
    /usr/local/bin/cfssljson \
    /usr/local/bin/kubectl \
    && adduser -u $NONROOT_UID -D nonroot $NONROOT_GID \
    && mkdir -p -m 775 /kubemod-crt

COPY --chown=nonroot:nonroot files/ kubemod-crt/

USER nonroot

WORKDIR /kubemod-crt
