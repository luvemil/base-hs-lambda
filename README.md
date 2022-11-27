# base-hs-lambda

Base image to extend lambci/lambda:build-provided with a haskell build
environment.

The idea is to build a separate image for each resolver. In order
to speed up the build times we already add some packages
(aeson and aws-lambda-haskell-runtime at the time of writing).
