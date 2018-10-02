#!/bin/bash

function usage() {
    echo "Usage: $0 filename.tex [--output-dir=build/]"
    exit 1
}

for i in "$@"; do
case $i in
    -o=*|--output-dir=*)
    outdir="${i#*=}"
    shift
    ;;
    -*)
    echo "Error: Unknown command '$i'!"
    usage
    ;;
    *)
    fname=$i
    ;;
esac; done

if [ -z "$fname" ]; then
    echo Error: No file name found!
    usage
fi

if [ ! -f "$fname" ]; then
    echo "Error: File '$fname' does not exists!"
    usage
fi

if [ -z "$outdir" ]; then
    outdir=$PWD
fi

if ! [[ "$outdir" = /* ]]; then
    outdir=$PWD/$outdir
fi

if ! [ -d "$outdir" ]; then
    echo "creating directory '$outdir' ..."
    mkdir -p $outdir
fi

exec docker run --rm -it --user="$(id -u):$(id -g)" \
-v "$PWD":/input:ro \
-v "$outdir":/output \
avitase/feynmaker:latest /bin/bash -c \
"./make.sh $fname"
