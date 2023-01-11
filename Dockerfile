ARG RESOLVER=nightly-2022-11-12

FROM lambci/lambda:build-provided.al2 as build

# SHELL ["/bin/bash", "--rcfile", "~/.profile", "-c"]

USER root

RUN yum update -y ca-certificates

# Saving default system libraries before doing anything else
RUN du -a /lib64 /usr/lib64 | cut -f2 > /root/default-libraries

# Installing basic dependencies
RUN yum install -y \
    git-core \
    tar \
    sudo \
    xz \
    make \
    gmp-devel \
    postgresql-devel \
    libicu libicu-devel \
    libyaml libyaml-devel

RUN yum groupinstall -y "Development Tools" "Development Libraries"

# Installing Haskell Stack
RUN curl -sSL https://get.haskellstack.org/ | sh

ARG RESOLVER

COPY package.yaml stack.yaml ./

# Setting up GHC
RUN stack setup --resolver=${RESOLVER}

# TODO: configure the resolver and install the base libraries
RUN stack install --resolver ${RESOLVER} \
        aws-lambda-haskell-runtime \
        aeson
