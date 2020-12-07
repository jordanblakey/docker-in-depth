# Docker Crash Course

## Installation (Mac)

```sh
brew cask install docker
docker # Get all commands
docker --version # Check installation
docker info # Check high level Docker Engine installation info
docker <subcommand> --help # Get help for a command
```

## Docker Components

What do we mean when we say Docker?

### Docker Engine: client-server application with 3 parts

- dockerd: a server/daemon process which runs containers.
- APIs: programs use this to interface with the daemon.
- `docker` CLI: manage containers, images, upload/download to Docker Hub

### Docker Compose: A tool for defining and running multi-container Docker applications.

- Step 1: define your app's environment with a Dockerfile so it can be reproduced.
- Step 2: Define the services that make up your app in a docker-compose.yml
- Step 3: Run docker-compose up and Compose starts and runs your entire app.

A `docker-compose.yml` file looks like this:

```sh
version: "3.8"
services:
  web:
    build: .
    ports:
      - "5000:5000"
    volumes:
      - .:/code
      - logvolume01:/var/log
    links:
      - redis
  redis:
    image: redis
volumes:
  logvolume01: {}
```

### Docker Hub

Docker Hub is a repository for sharing and versioning `container images`. It also features Teams/Orgs, Official Images, Automatic Builds (based on code repos), and Webhooks.

## docker-compose CLI Commands

```sh
docker-compose up # Run the docker-compose.yml file form the current working directory
docker-compose up -d # Run the above in detached mode (background)
docker-compose ps # Check docker-compose services running in the background.
docker-compose run # run ad-hoc commands for your services
docker-compose run <service-name> env # check env variables available to the "web" service
docker-compose stop # stop background services manually
docker-compose down # stop all services, destroy containers
docker-compose down --volumes # stop all services, destroy containers and persistent volumes
```

## docker CLI Commands

```sh
docker build -t friendlyhello . # Build image based on cwd Dockerfile
docker run -p 4000:80 friendlyhello # Run "frieldlyhello" mapping port 4000 to 80
docker run -d -p 4000:80 friendlyhello # Same, but in detached mode
docker container ls # List running containers
docker container ls -q # Get IDs for running containers
docker container ls -a # Get all containers, including those not running
docker container stop <id or name> # Gracefully stop a container
docker container kill <id or name> # Forcefully stop a container
docker container rm <id or name> # Remove container from machine
docker system prune -a # Remove all stopped containers and unused images
docker image ls -a # List all images
docker image rm <image id> # Remove an image
docker image rm $(docker image ls -a -q) # Remove all images
docker login # Login to Docker Hub
docker tag <image> username/repository:tag # Tag <image> for upload to the registry
docker push username/repository:tag # Upload tagged image to the registry
docker run username/repository:tag # Run an image from the registry

```