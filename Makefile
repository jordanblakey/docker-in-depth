.PHONY: all build push

# IMAGE_NAME = jordantblakey/alpine_scripting
IMAGE_NAME = ghcr.io/jordanblakey/alpine_scripting
IMAGE_TAG = latest
DOCKERFILE_DIR = alpine_scripting

all:
	make clean
	make build
	make push

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) $(DOCKERFILE_DIR)

push: build
	docker push $(IMAGE_NAME):$(IMAGE_TAG)

run:
	docker run --rm $(IMAGE_NAME):$(IMAGE_TAG)

pull:
	docker pull $(IMAGE_NAME):$(IMAGE_TAG)

clean:
	docker rmi $(IMAGE_NAME):$(IMAGE_TAG) || true
	docker image prune -f
	docker system prune -f
	docker volume prune -f
	docker network prune -f
	docker container prune -f
	echo "Cleaned up Docker images, volumes, networks, and containers."