# Golang

## Get start 

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
make build -e APP=hello
```

Uses `-e` parameter to pass the name of file that is in `src/` directory.

* Run application

```bash
make run -e APP=hello
```

Uses `run` target to executes binary with the docker container.
Uses `-e APP=<application_name>` to set the application name, just pass the name without the `.go` extensions.

* Clean images

Target that forces prune all docker images (be careful to run).
Before execute the target, valid yours docker images.

```bash
make clean
```