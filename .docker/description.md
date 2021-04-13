# Node-RED

## Low-code programming for event-driven applications

To run Node-RED in Docker in its simplest form just run:

```
docker run -it -p 1880:1880 -v myNodeREDdata:/data --name mynodered dennis14e/node-red
```

or for the minimal version:

```
docker run -it -p 1880:1880 -v myNodeREDdata:/data --name mynodered dennis14e/node-red:latest-minimal
```

The minimal version does not contain build tools or support for projects.


## Image Variations

The Node-RED images come in different variations and are supported by manifest lists (auto-detect architecture).
This makes it more easy to deploy in a multi architecture Docker environment. E.g. a Docker Swarm with mix of Raspberry Pi's and amd64 nodes.

The tag naming convention is `v<node-red-version>-<node-version>-<os>-<image-type>-<architecture>`, where:
- `<node-red-version>` is the Node-RED version.
- `<node-version>` is the Node JS version.
- `<os>` is the os of the base image and is optional, can be either _none_, alpine or buster.
    - _none_ : is the default base image (alpine)
    - alpine : uses node:`<node-version>`-alpine as base image
    - buster : uses node:`<node-version>`-buster-slim as base image
- `<image-type>` is type of image and is optional, can be either _none_ or minimal.
    - _none_ : is the default and has Python 2 & Python 3 + devtools installed
    - minimal : has no Python installed and no devtools installed

The minimal versions (without python and build tools) are not able to install nodes that require any locally compiled native code.

For example - to run the latest minimal version, you would run:

```
docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered dennis14e/node-red:latest-minimal
```

The default Node-RED images are based on [official Node JS Alpine Linux](https://hub.docker.com/_/node/) images to keep them as small as possible.
Using Alpine Linux reduces the built image size, but removes standard dependencies that are required for native module compilation.
If you want to add dependencies with native dependencies, extend the Node-RED image with the missing packages on running containers or try using the Debian Buster based images.

The following table shows the variety of provided Node-RED images.

| **Tag**                    |**Node**| **Arch** | **Python** |**Dev**| **Base Image**         |
|----------------------------|--------|----------|------------|-------|------------------------|
| 1.3.1-10                   |   10   | amd64    |   2.x 3.x  |  yes  | node:10-alpine         |
| 1.3.1-10-alpine            |        | arm32v6  |            |       |                        |
| latest-10                  |        | arm32v7  |            |       |                        |
|                            |        | arm64v8  |            |       |                        |
|                            |        | s390x    |            |       |                        |
|                            |        |          |            |       |                        |
| 1.3.1-10-minimal           |   10   | amd64    |     no     |  no   | node:10-alpine         |
| 1.3.1-10-alpine-minimal    |        | arm32v6  |            |       |                        |
| latest-10-minimal          |        | arm32v7  |            |       |                        |
|                            |        | arm64v8  |            |       |                        |
|                            |        | s390x    |            |       |                        |
|                            |        |          |            |       |                        |
| 1.3.1-10-buster            |   10   | amd64    |   2.x 3.x  |  yes  | node:10-buster-slim    |
| latest-10-buster           |        | arm32v7  |            |       |                        |
|                            |        | arm64v8  |            |       |                        |
|                            |        | s390x    |            |       |                        |
|                            |        |          |            |       |                        |
| 1.3.1-10-buster-minimal    |   10   | amd64    |     no     |  no   | node:10-buster-slim    |
| latest-10-buster-minimal   |        | arm32v7  |            |       |                        |
|                            |        | arm64v8  |            |       |                        |
|                            |        | s390x    |            |       |                        |


| **Tag**                    |**Node**| **Arch** | **Python** |**Dev**| **Base Image**         |
|----------------------------|--------|----------|------------|-------|------------------------|
| 1.3.1-12                   |   12   | amd64    |   2.x 3.x  |  yes  | node:12-alpine         |
| 1.3.1-12-alpine            |        | arm32v6  |            |       |                        |
| latest-12                  |        | arm32v7  |            |       |                        |
|                            |        | arm64v8  |            |       |                        |
|                            |        | s390x    |            |       |                        |
|                            |        |          |            |       |                        |
| 1.3.1-12-minimal           |   12   | amd64    |     no     |  no   | node:12-alpine         |
| 1.3.1-12-alpine-minimal    |        | arm32v6  |            |       |                        |
| latest-12-minimal          |        | arm32v7  |            |       |                        |
|                            |        | arm64v8  |            |       |                        |
|                            |        | s390x    |            |       |                        |
|                            |        |          |            |       |                        |
| 1.3.1-12-buster            |   12   | amd64    |   2.x 3.x  |  yes  | node:12-buster-slim    |
| latest-12-buster           |        | arm32v7  |            |       |                        |
|                            |        | arm64v8  |            |       |                        |
|                            |        | s390x    |            |       |                        |
|                            |        |          |            |       |                        |
| 1.3.1-12-buster-minimal    |   12   | amd64    |     no     |  no   | node:12-buster-slim    |
| latest-12-buster-minimal   |        | arm32v7  |            |       |                        |
|                            |        | arm64v8  |            |       |                        |
|                            |        | s390x    |            |       |                        |


| **Tag**                    |**Node**| **Arch** | **Python** |**Dev**| **Base Image**         |
|----------------------------|--------|----------|------------|-------|------------------------|
| 1.3.1-14                   |   14   | amd64    |   2.x 3.x  |  yes  | node:14-alpine         |
| 1.3.1-14-alpine            |        | arm32v6  |            |       |                        |
| latest-14                  |        | arm32v7  |            |       |                        |
| latest                     |        | arm64v8  |            |       |                        |
|                            |        | s390x    |            |       |                        |
|                            |        |          |            |       |                        |
| 1.3.1-14-minimal           |   14   | amd64    |     no     |  no   | node:14-alpine         |
| 1.3.1-14-alpine-minimal    |        | arm32v6  |            |       |                        |
| latest-14-minimal          |        | arm32v7  |            |       |                        |
| latest-minimal             |        | arm64v8  |            |       |                        |
|                            |        | s390x    |            |       |                        |
|                            |        |          |            |       |                        |
| 1.3.1-14-buster            |   14   | amd64    |   2.x 3.x  |  yes  | node:14-buster-slim    |
| latest-14-buster           |        | arm32v7  |            |       |                        |
|                            |        | arm64v8  |            |       |                        |
|                            |        | s390x    |            |       |                        |
|                            |        |          |            |       |                        |
| 1.3.1-14-buster-minimal    |   14   | amd64    |     no     |  no   | node:14-buster-slim    |
| latest-14-buster-minimal   |        | arm32v7  |            |       |                        |
|                            |        | arm64v8  |            |       |                        |
|                            |        | s390x    |            |       |                        |

All images have bash, tzdata, nano, curl, git, openssl and openssh-client pre-installed to support Node-RED's Projects feature.


This project is available on [GitHub](https://github.com/Dennis14e/node-red-docker).
