FROM ubuntu:16.04
WORKDIR /home/cloudbci-agent1/
RUN apk update && apk add -U git curl maven && rm -rf /var/cache/apk/*

