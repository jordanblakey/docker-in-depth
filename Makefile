.PHONY: all build push

RUNNER_IMAGE_NAME = ghcr.io/jordanblakey/gh_actions_runner
RUNNER_IMAGE_TAG = latest
RUNNER_DOCKERFILE_DIR = runner_container

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
	echo "https://${IMAGE_NAME}"

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

update_runner:
	docker build -t $(RUNNER_IMAGE_NAME):$(RUNNER_IMAGE_TAG) $(RUNNER_DOCKERFILE_DIR)
	docker run --rm $(RUNNER_IMAGE_NAME):$(RUNNER_IMAGE_TAG)
	echo "Pushing the runner container image to the registry..."
	read -p "Press enter to push container or Ctrl+C to cancel" res
	echo "Pushing the runner container image to the registry..."
	docker push $(RUNNER_IMAGE_NAME):$(RUNNER_IMAGE_TAG)
	echo "Runner container updated successfully."
	echo "https://${RUNNER_IMAGE_NAME}"