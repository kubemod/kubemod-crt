FROM alpine:3.6

ADD https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 /usr/local/bin/cfssl
ADD https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 /usr/local/bin/cfssljson
ADD https://storage.googleapis.com/kubernetes-release/release/v1.19.0/bin/linux/amd64/kubectl /usr/local/bin/kubectl
COPY files/ kubemod-crt/

RUN chmod +x \
  /usr/local/bin/cfssl \
  /usr/local/bin/cfssljson \
  /usr/local/bin/kubectl \
  /kubemod-crt/renew-certificates.sh

WORKDIR /kubemod-crt
