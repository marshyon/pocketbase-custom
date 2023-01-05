# syntax=docker/dockerfile:1

# FROM golang:1.16-ubuntu as builder
FROM golang:1.20rc2-buster as builder
WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go get github.com/pocketbase/pocketbase/plugins/jsvm@v0.10.4

RUN go build -o /pb

# FROM ubuntu:latest as downloader

# RUN apt update -y && apt install -y wget && wget https://github.com/marshyon/pb/releases/download/test/pb && chmod +x /pb

FROM ubuntu:latest

COPY --from=builder /pb /usr/local/bin/pocketbase
RUN mkdir /pb_data && mkdir /pb_public
EXPOSE 8090

# ENTRYPOINT ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/pb_data", "--publicDir=/pb_public"]
# ENTRYPOINT ["/usr/local/bin/pocketbase", "serve"]
# ENTRYPOINT ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:8090"]
# ENTRYPOINT ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/pb_data"]
ENTRYPOINT ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/pb_data", "--publicDir=/pb_public"]


