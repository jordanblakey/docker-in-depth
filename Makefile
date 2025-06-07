.PHONY: all build push

IMAGE_NAME = jordantblakey/alpine_scripting
IMAGE_TAG = latest
DOCKERFILE_DIR = alpine_scripting

all: push

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) $(DOCKERFILE_DIR)

push: build
	docker push $(IMAGE_NAME):$(IMAGE_TAG)