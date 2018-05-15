#
# targets:
#         - all: execute build and run targets
#         - build: build all files that is in /src
#         - run: executes binary with docker container
#         - clean: force prune all docker images (be careful to run) 

APP ?= hello
IMAGE ?= gode-dojo

all: build run

build:
	set -euo pipefail; \
	docker build -t $(IMAGE) .

run:
	set -euo pipefail; \
	docker run -it --rm $(IMAGE) ./$(APP)

clean:
	set -euo pipefail; \
	docker rmi -f $(shell docker images -aq)

.PHONY:
	all \
	clean \
	build \
	run	
