# Docker In Depth

## Basic Commands

```sh
brew cask install docker
docker # Get commands
docker —version
docker version -f {{.Server.Experimental}}] # Check if experimental mode enabled
docker-compose # Define and run multi-container applications with Docker.
docker-machine # Create and manage machines running Docker. (Remotely manage instances of # docker)
docker info
/Applications/Docker.app/Contents/MacOS/Docker --uninstall # uninstall Docker
docker container —help # get commands for a subcommand
docker container logs <container name>
```

## Working With Containers, Docker Hub

``` sh
docker build -t friendlyhello . # Create image using this directory's Dockerfile
docker run -p 4000:80 friendlyhello # Run "friendlyname" mapping port 4000 to 80
docker run -d -p 4000:80 friendlyhello        # Same thing, but in detached mode
docker container ls                # List all running containers. Alt: docker ps
docker container ls -q                          # Get ids for running containers
docker container ls -a             # List all containers, even those not running
docker container stop <hash>           # Gracefully stop the specified container
docker container kill <hash>         # Force shutdown of the specified container
docker container rm <hash>        # Remove specified container from this machine
docker container rm $(docker container ls -a -q)         # Remove all containers
docker system prune -a         # remove all stopped containers and unused images
docker image ls -a                             # List all images on this machine
docker image rm <image id>            # Remove specified image from this machine
docker image rm $(docker image ls -a -q)   # Remove all images from this machine
docker login             # Log in this CLI session using your Docker credentials
docker tag <image> username/repository:tag  # Tag <image> for upload to registry
docker push username/repository:tag            # Upload tagged image to registry
docker run username/repository:tag                   # Run image from a registry
```

## Services

In a distributed application, different pieces of the app are called “services.”
Services are really just "containers in production". The service codifies the
image it's running on: Ports, Replicas for scaling, etc.

Apps are defined in a `docker-compose.yml`.
Services are containeded in apps.

Single containers in a service are called "tasks", numbered by replication.

Swarm
<= App (Stack (networks & services), defined in docker-compose)
<= Services <= Containers (Tasks, instances of images)
<= Images (defined in Dockerfile)

```sh
docker swarm init                                         # Init a swarm manager
docker stack deploy -c docker-compose.yml getstartedlab     # Init app, services
# Changes to docker-compose.yml are done in place.
# Run the above again to propogate updates (i.e. increase # of replicas)
docker service ls                  # Get service ids for the current application
docker service ps getstartedlab_web                 # List service tasks details
docker inspect <task or container>                   # Inspect task or container
docker stack rm getstartedlab                        # Take down the stack (app)
docker swarm leave --force                                 # Take down the swarm
```