#!/bin/bash

IMAGE=avitase/feynmaker:latest
SRC=$PWD

if [ "$#" -lt 1 ]; then
    echo "Usage $0 [diagram.tex]"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo Error: File \'$1\' does not exists.
    echo "Usage $0 [diagram.tex]"
    exit 1
fi

exec docker run --rm -it --user="$(id -u):$(id -g)" \
-v "$SRC":/input:ro \
-v "$PWD":/output \
$IMAGE /bin/bash -c \
"./make.sh $1"
