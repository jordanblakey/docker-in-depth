# Docker In Depth

## Basic Commands

```sh
brew cask install docker
docker # Get commands
docker —version
docker version -f {{.Server.Experimental}} # Check if experimental mode enabled
docker-compose # Define and run multi-container applications with Docker.
docker-machine # Create and manage machines running Docker. (Remotely manage instances of # docker)
docker info # All High Level info
/Applications/Docker.app/Contents/MacOS/Docker --uninstall # uninstall Docker
docker container —help # get commands for a subcommand
docker container logs <container name>
```

## Working With Containers, Docker Hub

``` sh
docker build -t friendlyhello . # Create image using this directory's Dockerfile
docker run -p 4000:80 friendlyhello # Run "friendlyhello" mapping port 4000 to 80
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
Services are contained in apps.

Single containers in a service are called "tasks", numbered by replication.

Swarm
<= App (Stack (networks & services), defined in docker-compose)
<= Services (collections of load-balanced Tasks)
<= Containers (Tasks, instances of images)
<= Images (defined in Dockerfile)

To recap, while typing docker run is simple enough, the true implementation of a container in production is running it as a service. Services codify a container’s behavior in a Compose file, and this file can be used to scale, limit, and redeploy our app. Changes to the service can be applied in place, as it runs, using the same command that launched the service: docker stack deploy.

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

## Swarms

### Creation

```sh
docker-machine create --driver virtualbox myvm1 # Create physical machines (VMs) to add to the swarm.
docker-machine create --driver virtualbox myvm2
docker-machine stop myvm1 myvm2
docker-machine start myvm1 myvm2
docker-machine ls # list all machines
docker-machine ssh myvm1 # ssh into VM
docker swarm init --advertise-addr 192.168.99.100:2377 # This is the VMs IP, command ran via SSH
docker-machine ssh myvm2 # Add the second VM as a worker
docker swarm join --token SWMTKN-1-0cxjaatw725lbatu2zhrl8i101f7fpuyrwiifytli8q55rd8sc-dh3ravhyxx9eyz712k7v0qkuy 192.168.99.100:2377
docker-machine ssh myvm1
docker swarm join-token manager # Get a token to add a node as a manager
```

### Management

```sh
docker node ls # List all nodes in the swarm
docker node demote <id> # demote node from swarm manager
docker node promote <id> # promote node to swarm manager
docker node inspect <id> # detailed info on a node
docker node ps # list tasks running
docker node rm
docker node update
```

### All Docker Machine Commands

docker-machine create --driver virtualbox myvm1 # Create a VM (Mac, Win7, Linux)
docker-machine env myvm1                # View basic information about your node
docker-machine ssh myvm1 "docker node ls"         # List the nodes in your swarm
docker-machine ssh myvm1 "docker node inspect <node ID>"        # Inspect a node
docker-machine ssh myvm1 "docker swarm join-token -q worker"   # View join token
docker-machine ssh myvm1   # Open an SSH session with the VM; type "exit" to end
docker node ls                # View nodes in swarm (while logged on to manager)
docker-machine ssh myvm2 "docker swarm leave"  # Make the worker leave the swarm
docker-machine ssh myvm1 "docker swarm leave -f" # Make master leave, kill swarm
docker-machine ls # list VMs, asterisk shows which VM this shell is talking to
docker-machine start myvm1            # Start a VM that is currently not running
docker-machine env myvm1      # show environment variables and command for myvm1
eval $(docker-machine env myvm1)         # Mac command to connect shell to myvm1
docker stack deploy -c <file> <app>  # Deploy an app; command shell must be set to talk to manager (myvm1), uses local Compose file
docker-machine scp docker-compose.yml myvm1:~ # Copy file to node's home dir (only required if you use ssh to connect to manager and deploy the app)
docker-machine ssh myvm1 "docker stack deploy -c <file> <app>"   # Deploy an app using ssh (you must have first copied the Compose file to myvm1)
eval $(docker-machine env -u)     # Disconnect shell from VMs, use native docker
docker-machine stop $(docker-machine ls -q)               # Stop all running VMs
docker-machine rm $(docker-machine ls -q) # Delete all VMs and their disk images
