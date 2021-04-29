#!/usr/bin/env bash
set -ex

if [["$TAG_SUFFIX" != "minimal" ]]
then
    apk add --no-cache --virtual devtools build-base linux-headers udev python2 python3
fi
