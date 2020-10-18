#!/usr/bin/env bash
docker build -t kubemod/kubemod-crt:local .
./build/cleanup.sh
