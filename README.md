# Node-RED Docker

[![Build release images](https://github.com/Dennis14e/node-red-docker/actions/workflows/build-release.yml/badge.svg)](https://github.com/Dennis14e/node-red-docker/actions/workflows/build-release.yml)
[![Build develop images](https://github.com/Dennis14e/node-red-docker/actions/workflows/build-develop.yml/badge.svg)](https://github.com/Dennis14e/node-red-docker/actions/workflows/build-develop.yml)
[![DockerHub Pull](https://img.shields.io/docker/pulls/dennis14e/node-red.svg)](https://hub.docker.com/r/dennis14e/node-red/)
[![DockerHub Stars](https://img.shields.io/docker/stars/dennis14e/node-red.svg?maxAge=2592000)](https://hub.docker.com/r/dennis14e/node-red/)

This project describes some of the many ways Node-RED can be run under Docker and has support for multiple architectures.
Some basic familiarity with Docker and the [Docker Command Line](https://docs.docker.com/engine/reference/commandline/cli/) is assumed.


## Supported architectures

- Alpine images (default)
  - `amd64`
  - `arm32v6`
  - `arm32v7`
  - `arm64v8`
  - `s390x`

- Debian Bullseye images (see [Debian ARM ports](https://wiki.debian.org/ArmPorts))
  - `amd64`
  - `arm32v7`
  - `arm64v8`
  - `s390x`


## Quick Start
To run in Docker in its simplest form just run:

```
docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered dennis14e/node-red
```

Let's dissect that command:

```
docker run              - run this container, initially building locally if necessary
-it                     - attach a terminal session so we can see what is going on
-p 1880:1880            - connect local port 1880 to the exposed internal port 1880
-v node_red_data:/data  - mount the host node_red_data directory to the container /data directory so any changes made to flows are persisted
--name mynodered        - give this machine a friendly local name
dennis14e/node-red      - the image to base it on - currently Node-RED v2.0.6 with Node.js 14
```


Running that command should give a terminal window with a running instance of Node-RED.

```
Welcome to Node-RED
===================

18 May 18:55:17 - [info] Node-RED version: v2.0.6
18 May 18:55:17 - [info] Node.js  version: v14.17.0
18 May 18:55:17 - [info] Linux 5.4.0-73-generic x64 LE
18 May 18:55:18 - [info] Loading palette nodes
18 May 18:55:20 - [info] Settings file  : /data/settings.js
18 May 18:55:20 - [info] Context store  : 'default' [module=memory]
18 May 18:55:20 - [info] User directory : /data
18 May 18:55:20 - [warn] Projects disabled : editorTheme.projects.enabled=false
18 May 18:55:20 - [info] Flows file     : /data/flows.json
18 May 18:55:20 - [info] Creating new flow file
18 May 18:55:20 - [warn]

---------------------------------------------------------------------
Your flow credentials file is encrypted using a system-generated key.

If the system-generated key is lost for any reason, your credentials
file will not be recoverable, you will have to delete it and re-enter
your credentials.

You should set your own key using the 'credentialSecret' option in
your settings file. Node-RED will then re-encrypt your credentials
file using your chosen key the next time you deploy a change.
---------------------------------------------------------------------

13 Apr 12:31:16 - [info] Server now running at http://127.0.0.1:1880/
13 Apr 12:31:16 - [info] Starting flows
13 Apr 12:31:16 - [info] Started flows

[...]
```

You can then browse to `http://{host-ip}:1880` to get the familiar Node-RED desktop.


The advantage of doing this is that by giving it a name (mynodered) we can manipulate it
more easily, and by fixing the host port we know we are on familiar ground.
Of course this does mean we can only run one instance at a time... but one step at a time folks...

If we are happy with what we see, we can detach the terminal with `Ctrl-p` `Ctrl-q` - the
container will keep running in the background.

To reattach to the terminal (to see logging) run:

```
$ docker attach mynodered
```

If you need to restart the container (e.g. after a reboot or restart of the Docker daemon):

```
$ docker start mynodered
```

and stop it again when required:

```
$ docker stop mynodered
```

**Healthcheck**: to turn off the Healthcheck add `--no-healthcheck` to the run command.


## Image Variations
The Node-RED images come in different variations and are supported by manifest lists (auto-detect architecture).
This makes it more easy to deploy in a multi architecture Docker environment. E.g. a Docker Swarm with mix of Raspberry Pi's and amd64 nodes.

The tag naming convention is `v<node-red-version>-<node-version>-<os>-<image-type>`, where:
- `<node-red-version>` is the Node-RED version, can be either latest or v`<node-red-version>`.
  - latest : is the current Node-RED version (currently 2.0.5)
  - v`<node-red-version>` : is a specific Node-RED version (e.g. v1.3.4)
- `<node-version>` is the Node.js version and is optional, can be either _none_, 12, 14 or 16.
  - _none_ : is the default Node.js version (14)
  - 12, 14, 16 : is Node.js version 12, 14, 16
- `<os>` is the os of the base image and is optional, can be either _none_, alpine or bullseye.
  - _none_ : is the default base image (alpine)
  - alpine   : uses node:`<node-version>`-alpine as base image
  - bullseye : uses node:`<node-version>`-bullseye-slim as base image
- `<image-type>` is type of image and is optional, can be either _none_ or minimal.
  - _none_ : is the default and has Python 2 & Python 3 + devtools installed
  - minimal : has no Python installed and no devtools installed

The minimal versions (without python and build tools) are not able to install nodes that require any locally compiled native code.

For example - to run the latest minimal version, you would run:

```
docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered dennis14e/node-red:latest-minimal
```

The default Node-RED images are based on [official Node.js Alpine Linux](https://hub.docker.com/_/node/) images to keep them as small as possible.
Using Alpine Linux reduces the built image size, but removes standard dependencies that are required for native module compilation.
If you want to add dependencies with native dependencies, extend the Node-RED image with the missing packages on running containers or try using the Debian Bullseye based images.

The following table shows the variety of provided Node-RED images.

- Alpine, Node 12, Python 2 + 3, based on `node:12-alpine`
  - `v2.0.6-12`
  - `latest-12`
  - `v2.0.6-12-alpine`
  - `latest-12-alpine`

- Alpine, Node 12, based on `node:12-alpine`
  - `v2.0.6-12-minimal`
  - `latest-12-minimal`
  - `v2.0.6-12-alpine-minimal`
  - `latest-12-alpine-minimal`

- Debian Bullseye, Node 12, Python 2 + 3, based on `node:12-bullseye-slim`
  - `v2.0.6-12-bullseye`
  - `latest-12-bullseye`

- Debian Bullseye, Node 12, based on `node:12-bullseye-slim`
  - `v2.0.6-12-bullseye-minimal`
  - `latest-12-bullseye-minimal`


- Alpine Node 14, Python 2 + 3, based on `node:14-alpine`
  - `v2.0.6`
  - **`latest`**
  - `v2.0.6-alpine`
  - `latest-alpine`
  - `v2.0.6-14`
  - `latest-14`
  - `v2.0.6-14-alpine`
  - `latest-14-alpine`

- Alpine Node 14, based on `node:14-alpine`
  - `v2.0.6-minimal`
  - **`latest-minimal`**
  - `v2.0.6-alpine-minimal`
  - `latest-alpine-minimal`
  - `v2.0.6-14-minimal`
  - `latest-14-minimal`
  - `v2.0.6-14-alpine-minimal`
  - `latest-14-alpine-minimal`

- Debian Bullseye, Node 14, Python 2 + 3, based on `node:14-bullseye-slim`
  - `v2.0.6-bullseye`
  - `latest-bullseye`
  - `v2.0.6-14-bullseye`
  - `latest-14-bullseye`

- Debian Bullseye, Node 14, based on `node:14-bullseye-slim`
  - `v2.0.6-bullseye-minimal`
  - `latest-bullseye-minimal`
  - `v2.0.6-14-bullseye-minimal`
  - `latest-14-bullseye-minimal`


- Alpine Node 16, Python 2 + 3, based on `node:16-alpine`
  - `v2.0.6-16`
  - `latest-16`
  - `v2.0.6-16-alpine`
  - `latest-16-alpine`

- Alpine Node 16, based on `node:16-alpine`
  - `v2.0.6-16-minimal`
  - `latest-16-minimal`
  - `v2.0.6-16-alpine-minimal`
  - `latest-16-alpine-minimal`

- Debian Bullseye, Node 16, Python 2 + 3, based on `node:16-bullseye-slim`
  - `v2.0.6-16-bullseye`
  - `latest-16-bullseye`

- Debian Bullseye, Node 16, based on `node:16-bullseye-slim`
  - `v2.0.6-16-bullseye-minimal`
  - `latest-16-bullseye-minimal`


All images have bash, tzdata, nano, curl, git, openssl and openssh-client pre-installed to support Node-RED's Projects feature.


## Managing User Data

Once you have Node-RED running with Docker, we need to
ensure any added nodes or flows are not lost if the container is destroyed.
This user data can be persisted by mounting a data directory to a volume outside the container.
This can either be done using a bind mount or a named data volume.

Node-RED uses the `/data` directory inside the container to store user configuration data.

Depending on how and where you mount the user data directory you may want to turn off the built in healthcheck function by adding `--no-healthcheck` to the run command.


### Using a Host Directory for Persistence (Bind Mount)

To save your Node-RED user directory inside the container to a host directory outside the container, you can use the command below.
To allow access to this host directory, the node-red user (default uid=1000) inside the container must have the same uid as the owner of the host directory.

```
docker run -it -p 1880:1880 -v /home/pi/.node-red:/data --name mynodered dennis14e/node-red
```

In this example the host `/home/pi/.node-red` directory is bound to the container `/data` directory.

**Note**: Users migrating from version 0.20 to 1.0 will need to ensure that any existing `/data`
directory has the correct ownership. As of 1.0 this needs to be `1000:1000`. This can be forced by
the command `sudo chown -R 1000:1000 path/to/your/node-red/data`

See [the wiki](https://github.com/node-red/node-red-docker/wiki/Permissions-and-Persistence) for detailed information
on permissions.


### Using Named Data Volumes

Docker also supports using named [data volumes](https://docs.docker.com/engine/tutorials/dockervolumes/)
to store persistent or shared data outside the container.

To create a new named data volume to persist our user data and run a new
container using this volume.

```
$ docker volume create --name node_red_data_vol
$ docker volume ls
DRIVER              VOLUME NAME
local               node_red_data_vol
$ docker run -it -p 1880:1880 -v node_red_data_vol:/data --name mynodered dennis14e/node-red
```

Using Node-RED to create and deploy some sample flows, we can now destroy the
container and start a new instance without losing our user data.

```
$ docker rm mynodered
$ docker run -it -p 1880:1880 -v node_red_data_vol:/data --name mynodered dennis14e/node-red
```


## Updating

As the /data is now preserved outside of the container, updating the base container image
is now as simple as:

```
$ docker pull dennis14e/node-red
$ docker stop mynodered
$ docker start mynodered
```


## Docker Stack / Docker Compose

Below an example of a Docker Compose file which can be run by `docker stack` or `docker-compose`.
Please refer to the official Docker pages for more info about [Docker stack](https://docs.docker.com/engine/reference/commandline/stack/) and [Docker compose](https://docs.docker.com/compose/).

```
################################################################################
# Node-RED Stack or Compose
################################################################################
# docker stack deploy node-red --compose-file docker-compose-node-red.yml
# docker-compose -f docker-compose-node-red.yml -p myNoderedProject up
################################################################################
version: "3.7"

services:
  node-red:
    image: dennis14e/node-red:latest
    environment:
      - TZ=Europe/Amsterdam
    ports:
      - "1880:1880"
    networks:
      - node-red-net
    volumes:
      - ~/node-red/data:/data

networks:
  node-red-net:
```

The above compose file:
- creates a node-red service
- pulls the latest node-red image
- sets the timezone to Europe/Amsterdam
- Maps the container port 1880 to the the host port 1880
- creates a node-red-net network and attaches the container to this network
- persists the `/data` dir inside the container to the users local `node-red/data` directory. The `node-red/data` directory must exist prior to starting the container.


## Project Layout
This repository contains Dockerfiles to build the Node-RED Docker images listed above.


### package.json

The package.json is a metafile that downloads and installs the required version
of Node-RED and any other npms you wish to install at build time. During the
Docker build process, the dependencies are installed under `/usr/src/node-red`.

The main sections to modify are

```
    "dependencies": {
        "node-red": "^2.0.5",            <-- set the version of Node-RED here
        "node-red-dashboard": "*"        <-- add any extra npm packages here
    },
```

This is where you can pre-define any extra nodes you want installed every time
by default, and then

```
    "scripts": {
        "start": "node-red -v $FLOWS"
    },
```

This is the command that starts Node-RED when the container is run.


### Startup

Node-RED is started using NPM start from this `/usr/src/node-red`, with the `--userDir`
parameter pointing to the `/data` directory on the container.

The flows configuration file is set using an environment parameter (**FLOWS**),
which defaults to *'flows.json'*. This can be changed at runtime using the
following command-line flag.

```
docker run -it -p 1880:1880 -e FLOWS=my_flows.json -v node_red_data:/data dennis14e/node-red
```

**Note**: If you set `-e FLOWS=""` then the flow file can be set via the *flowFile*
property in the `settings.js` file.

Node.js runtime arguments can be passed to the container using an environment
parameter (**NODE_OPTIONS**). For example, to fix the heap size used by
the Node.js garbage collector you would use the following command.

```
docker run -it -p 1880:1880 -e NODE_OPTIONS="--max_old_space_size=128" -v node_red_data:/data dennis14e/node-red
```

Other useful environment variables include

 - -e NODE_RED_ENABLE_SAFE_MODE=false # setting to true starts Node-RED in safe (not running) mode
 - -e NODE_RED_ENABLE_PROJECTS=false  # setting to true starts Node-RED with the projects feature enabled


### Node-RED Admin Tool

Using the administration tool, with port forwarding on the container to the host
system, extra nodes can be installed without leaving the host system.

```
$ npm install -g node-red-admin
$ node-red-admin install node-red-node-openwhisk
```

This tool assumes Node-RED is available at the following address
`http://localhost:1880`.

Refreshing the browser page should now reveal the newly added node in the palette.

### Node-RED Commands from the host

Admin commands can also be accessed without installing npm or the
node-red-admin tool on the host machine. Simply prepend your command
with "npx" and apply it to the container - e.g

```
$ docker exec -it mynodered npx node-red admin hash-pw
```

### Container Shell

```
$ docker exec -it mynodered /bin/bash
```

Will give a command line inside the container - where you can then run the npm install
command you wish - e.g.

```
$ cd /data
$ npm install node-red-node-smooth
$ exit
$ docker stop mynodered
$ docker start mynodered
```

Refreshing the browser page should now reveal the newly added node in the palette.


### Building Custom Image

Creating a new Docker image, using the public Node-RED images as the base image,
allows you to install extra nodes during the build process.

This Dockerfile builds a custom Node-RED image with the flightaware module
installed from NPM.

```
FROM dennis14e/node-red
RUN npm install node-red-contrib-flightaware
```

Alternatively, you can modify the package.json in this repository and re-build
the images from scratch. This will also allow you to modify the version of
Node-RED that is installed.


## Running headless

The barest minimum we need to just run Node-RED is

```
$ docker run -d -p 1880:1880 dennis14e/node-red
```

This will create a local running instance of a machine - that will have some
docker id number and be running on a random port... to find out run

```
$ docker ps
CONTAINER ID        IMAGE                            COMMAND             CREATED             STATUS                     PORTS                     NAMES
4bbeb39dc8dc        dennis14e/node-red:latest        "npm start"         4 seconds ago       Up 4 seconds               0.0.0.0:49154->1880/tcp   furious_yalow
```

You can now point a browser to the host machine on the tcp port reported back, so in the example
above browse to `http://{host-ip}:49154`

**NOTE**: as this does not mount the `/data` volume externally any changes to flows will not be saved and if the container is redeployed or upgraded these will be lost. The volume may persist on the host filing sysem and can probably be retrieved and remounted if required.


## Linking Containers

You can link containers "internally" within the docker runtime by using Docker [user-defined bridges](https://docs.docker.com/network/bridge/).

Before using a bridge, it needs to be created.  The command below will create a new bridge called **iot**

```
$ docker network create iot
```

Then all containers that need to communicate need to be added to the same bridge using the **--network** command line option

```
$ docker run -itd --network iot --name mybroker eclipse-mosquitto mosquitto -c /mosquitto-no-auth.conf
```

(no need to expose the port 1883 globally unless you want to... as we do magic below)

Then run Node-RED docker, also added to the same bridge

```
$ docker run -itd -p 1880:1880 --network iot --name mynodered dennis14e/node-red
```

containers on the same user-defined bridge can take advantage of the built in name resolution provided by the bridge and use the container name (specified using the **--name** option) as the target hostname.


In the above example the broker can be reached from the Node-RED application using hostname *mybroker*.

Then a simple flow like below show the mqtt nodes connecting to the broker

```
[{"id":"c51cbf73.d90738","type":"mqtt in","z":"3fa278ec.8cbaf","name":"","topic":"test","broker":"5673f1d5.dd5f1","x":290,"y":240,"wires":[["7781c73.639b8b8"]]},{"id":"7008d6ef.b6ee38","type":"mqtt out","z":"3fa278ec.8cbaf","name":"","topic":"test","qos":"","retain":"","broker":"5673f1d5.dd5f1","x":517,"y":131,"wires":[]},{"id":"ef5b970c.7c864","type":"inject","z":"3fa278ec.8cbaf","name":"","repeat":"","crontab":"","once":false,"topic":"","payload":"","payloadType":"date","x":290,"y":153,"wires":[["7008d6ef.b6ee38"]]},{"id":"7781c73.639b8b8","type":"debug","z":"3fa278ec.8cbaf","name":"","active":true,"tosidebar":true,"console":false,"tostatus":true,"complete":"payload","targetType":"msg","statusVal":"payload","statusType":"auto","x":505,"y":257,"wires":[]},{"id":"5673f1d5.dd5f1","type":"mqtt-broker","z":"","name":"","broker":"mybroker","port":"1883","clientid":"","usetls":false,"compatmode":false,"keepalive":"15","cleansession":true,"birthTopic":"","birthQos":"0","birthRetain":"false","birthPayload":"","closeTopic":"","closeRetain":"false","closePayload":"","willTopic":"","willQos":"0","willRetain":"false","willPayload":""}]
```

This way the internal broker is not exposed outside of the docker host - of course
you may add `-p 1883:1883`  etc to the broker run command if you want other systems outside your computer to be able to use the broker.

### Docker-Compose linking example

Another way to link containers is by using docker-compose. The following docker-compose.yml
file creates a Node-RED instance, and a local MQTT broker instance. In the Node-RED flow the broker can be addressed simply as `mybroker` at its default port `1883`.

```
version: "3.7"

services:
  mynodered:
    image: dennis14e/node-red
    restart: unless-stopped
    volumes:
      - /home/pi/.node-red:/data
    ports:
      - 1880:1880
  mybroker:
    image: eclipse-mosquitto
    restart: unless-stopped
    command: mosquitto -c /mosquitto-no-auth.conf
```

## Debugging containers

Sometimes it is useful to debug the code which is running inside the container.  Two scripts (*'debug'* and *'debug_brk'* in the package.json file) are available to start Node.js in debug mode, which means that Node.js will start listening (to port 9229) for a debug client. Various remote debugger tools (like Visual Code, Chrome Developer Tools ...) can be used to debug a Node-RED application.  A [wiki](https://github.com/node-red/node-red-docker/wiki/Debug-container-via-Chrome-Developer-Tools) page has been provided, to explain step-by-step how to use the Chrome Developer Tools debugger.

1. In most cases the *'debug'* script will be sufficient, to debug a Node-RED application that is fully up-and-running (i.e. when the application startup code is not relevant).  The Node.js server can be started in debug mode using following command:

```
$ docker run -it -p 1880:1880 -p 9229:9229 -v node_red_data:/data --name mynodered --entrypoint npm dennis14e/node-red run debug -- --userDir /data
```

2. In case debugging of the Node-RED startup code is required, the  *'debug_brk'* script will instruct Node.js to break at the first statement of the Node-RED application.  The Node.js server can be started in debug mode using following command:

```
$ docker run -it -p 1880:1880 -p 9229:9229 -v node_red_data:/data --name mynodered --entrypoint npm dennis14e/node-red run debug_brk -- --userDir /data
```

Note that in this case Node.js will wait - at the first statement of the Node-RED application - until a debugger client connects...

As soon as Node.js is listening to the debug port, this will be shown in the startup log:
```
Debugger listening on ws://0.0.0.0:9229/...
```

Let's dissect both commands:

```
docker run              - run this container, initially building locally if necessary
-it                     - attach a terminal session so we can see what is going on
-p 1880:1880            - connect local port 1880 to the exposed internal port 1880
-p 9229:9229            - connect local port 9229 to the exposed internal port 9229 (for debugger communication)
-v node_red_data:/data  - mount the internal /data to the host mode_red_data directory
--name mynodered        - give this machine a friendly local name
--entrypoint npm        - overwrite the default entrypoint (which would run the *'start'* script)
dennis14e/node-red      - the image to base it on - currently Node-RED v2.0.6
run debug(_brk)         - (npm) arguments for the custom endpoint (which must be added AFTER the image name!)
--                      - the arguments that will follow are not npm arguments, but need to be passed to the script
--userDir /data         - instruct the script where the Node-RED data needs to be stored
```


## Common Issues and Hints

Here is a list of common issues users have reported with possible solutions.


### User Permission Errors

See [the wiki](https://github.com/node-red/node-red-docker/wiki/Permissions-and-Persistence) for detailed information
on permissions.

If you are seeing *permission denied* errors opening files or accessing host devices, try running the container as the root user.

```
docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered -u root dennis14e/node-red
```

__References:__

- https://github.com/node-red/node-red-docker/issues/8
- https://github.com/node-red/node-red-docker/issues/15


### Accessing Host Devices

If you want to access a device from the host inside the container, e.g. serial port, use the following command-line flag to pass access through.

```
docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered --device=/dev/ttyACM0 dennis14e/node-red
```
__References:__

- https://github.com/node-red/node-red-docker/issues/15
- https://github.com/node-red/node-red-docker/issues/154

### Setting Timezone

If you want to modify the default timezone, use the TZ environment variable with the [relevant timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).
```
docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered -e TZ=Europe/London dennis14e/node-red
```

__References:__

- https://github.com/node-red/node-red-docker/issues/92
