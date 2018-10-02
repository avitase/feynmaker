#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage $0 [diagram.tex]"
    exit 1
fi

if [ ! -f "/input/$1" ]; then
    echo Error: File \'$1\' does not exists.
    echo "Usage $0 [diagram.tex]"
    exit 1
fi

cp /input/$1 .

pdffilename="${1%.*}.pdf"
make ${pdffilename} && cp build/${pdffilename} /output/
