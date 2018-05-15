#!/bin/bash

VERSION=1.10.2
ARCH=linux-amd64
ENV_SHELL=$(ps -e $$ | tail -n 1 | awk '{print $5}')

echo -e "Installing Golang ${VERSION}"
if [[ ! -d /usr/local/go/bin ]]; then
    echo -e "Download Golang ${VERSION}"
    curl -sL https://dl.google.com/go/go$VERSION.$ARCH.tar.gz | tar xz -C /usr/local 
else
    echo -e "Golang already installed"
fi

# create directory
if [[ ! -d ${HOME}/go ]]; then
    mkdir -p ${HOME}/go/{bin,src,pkg}
fi

# define vars
if [[ ${ENV_SHELL} == "/usr/bin/bash" ]]; then
    echo "export PATH=$PATH:/usr/local/go/bin" >> ${HOME}/.bashrc
    echo "export GOPATH=${HOME}/go/pkgs" >> ${HOME}/.bashrc
    echo "export GOROOT=${HOME}/go" >> ${HOME}/.bashrc
    echo "export GOBIN=${HOME}/go/bin" >> ${HOME}/.bashrc
    source ${HOME}/.bashrc
fi

if [[ ${ENV_SHELL} == "/usr/bin/zsh" ]]; then
    echo "export PATH=$PATH:/usr/local/go/bin" >> ${HOME}/.customrc.sh
    echo "export GOPATH=${HOME}/go/pkgs" >> ${HOME}/.customrc.sh 
    echo "export GOROOT=${HOME}/go" >> ${HOME}/.customrc.sh 
    echo "export GOBIN=${HOME}/go/bin" >> ${HOME}/.customrc.sh
    source ${HOME}/.bashrc
fi 
