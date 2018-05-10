#
# targets:
#         - all: execute build and run targets
#         - app: binary that is in /src
#         - image: image name that will be builded
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
