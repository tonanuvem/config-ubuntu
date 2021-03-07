FROM alpine:latest
ENV AWSCLI_VERSION "1.19.21"
RUN apk -v --no-cache --update add \
        python3 \
        py3-pip \
        groff \
        less \
        mailcap \
        curl \
        git \
        bash \
        && \
    pip --no-cache-dir install --upgrade awscli==${AWSCLI_VERSION} && \
    apk -v --purge del py-pip && \
    rm -rf /var/cache/apk/*
VOLUME /root/.aws
VOLUME /root/.kube
VOLUME /fiap
WORKDIR /usr/local/bin/
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" 
RUN chmod +x /usr/local/bin/kubectl
WORKDIR /fiap
