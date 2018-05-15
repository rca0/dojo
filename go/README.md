# Golang

## Get started 

Copy the repository:

```bash
git clone git@github.com:rca0/dojo.git
```

## Using Makefile

targets | description
--- | ---
all | executes build and run targets
build | build all files that is in /src
run | executes binary with docker container
clean | force prune all docker images 

With this option the Go binaires will be created and executed using Docker.

It is not needs to install Golang in your system operational, just the Docker.

[Get Docker](https://www.docker.com/get-docker)

* 1st Option:

```bash
make build
```

It will build all files with extensions `*.go` in `src/` path.

* 2nd Option:

```bash
make build -e APP=hello -e IMAGE=golang-image:1.0
```

Uses `-e APP=<application_name>` parameter to pass the name of file that is in `src/` directory.

Uses `-e IMAGE=<image_name>:<version>` parameter to create docker image. (`gode-dojo` is default)

* Run application

```bash
make run -e APP=hello -e IMAGE=golang-image:1.0
```

Uses `run` target to executes binary with the docker container.

Uses `-e APP=<application_name>` to set the application name, just pass the name without the `.go` extensions.

Uses `-e IMAGE=<image_name>:<version>` parameter to run with the docker image already created. (`gode-dojo` is default)

* Clean images

Target that forces prune all docker images (be careful to run).
Before execute the target, valid yours docker images.

```bash
make clean
```

## Using script to install Golang

This script will download and install Golang.

Will set up the environment variables:

* $PATH - add go binary to the PATH environment variable.
* $GOPATH - for your own go projects / 3rd party libraries (downloaded with `go get`)
* $GOROOT - for compiler/tools that comes from go installation. 
* $GOBIN - for install the binaries (using `go install`)

Will create the root diretory:

```bash
/home/${USER}/go
  /bin
  /pkg
  /src
```

Command line to install, works in `bash` and `zsh`.

```bash
sh scripts/install.sh
```
