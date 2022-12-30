ARG RESOLVER=nightly-2022-11-12

FROM lambci/lambda:build-provided

# SHELL ["/bin/bash", "--rcfile", "~/.profile", "-c"]

USER root

RUN yum update -y ca-certificates

# Installing Haskell Stack
RUN curl -sSL https://get.haskellstack.org/ | sh

ARG RESOLVER

COPY . .

# TODO: configure the resolver and install the base libraries
RUN stack install --resolver ${RESOLVER} \
        cryptonite --flag cryptonite:-use_target_attributes