# Feynmaker
![Docker Build Status](https://img.shields.io/docker/build/avitase/feynmaker.svg)

The container exposes a way to create Feynman diagrams as PDF files using the famous [Feynmf package](https://arxiv.org/abs/hep-ph/9505351). The idea is to mount your current directory to `/input` (read-only) and the desired output directory for the PDF file to `/output`. Say you want to generate a Feynman diagram from [example.tex](example.tex):
```
> cat example.tex
\begin{fmfgraph*}(35,25)
    \fmfbottom{i1,d1,o1}
    \fmftop{i2,d2,o2}
    \fmf{fermion,label=$\dquark$,label.side=left}{i1,v1}
    \fmf{fermion,label=$\uquark,,\cquark,,\tquark$,label.side=left}{v1,v2}
    \fmf{fermion,label=$\bquark$,label.side=left}{v2,o1}

    \fmf{fermion,label=$\bquarkbar$,label.side=left}{v3,i2}
    \fmf{fermion,label=$\uquarkbar,,\cquarkbar,,\tquarkbar$,label.side=left}{v4,v3}
    \fmf{fermion,label=$\dquarkbar$,label.side=left}{o2,v4}

    \fmffreeze

    \fmf{photon,label=$W$}{v3,v1}
    \fmf{photon,label=$W$}{v2,v4}

    \fmfdot{v1,v2,v3,v4}
\end{fmfgraph*}
```
by calling `./feynmaker.sh example.tex`.
This will wrap the content of [example.tex](example.tex) with the template defined in [template.tex](template.tex) and run the necessary `latex`, `mpost` and `pdflatex` commands for you and eventually exports the resulting PDF file to your current working directory (this is the default for the mount point of `/output`, defined in [feynmaker.sh](feynmaker.sh).)
```
> rm -f exmaple.pdf
> ./feynmaker.sh example.tex > /dev/null && ls -1t | head -n1
example.pdf
```

You can specify a dedicated build directory by passing `--output-dir=my-fancy-build-directory` to `./feynmaker.sh`. This directory will be mounted to `/output/` and inhabit your desired PDF file.

## Docker Pull Command
The container is accessible via the [Docker Hub](https://hub.docker.com/r/avitase/feynmaker/): `docker pull avitase/feynmaker`.
You can create your own `Dockerfile` and install additional dependencies of your project via `apt-get` or define your own template file.
