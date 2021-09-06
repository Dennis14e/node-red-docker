#!/usr/bin/env bash
set -ex

if [[ "$TAG_SUFFIX" != "minimal" ]]
then
    apt-get update && \
    apt-get install -y build-essential python2-dev python3-dev python2 python3 && \
    rm -rf /var/lib/apt/lists/*
fi
