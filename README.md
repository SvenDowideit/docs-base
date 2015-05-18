page_title: About the Docker documentation tools
page_description: Introduction to the Docker documentation tools
page_keywords: docker, introduction, documentation, about, technology, understanding, Dockerfile

# Docker documentation tools

This repository contains the HTML theme, and the build tools for
generating [the Docker documentation site](https://docs.docker.com).  The theme and the structures form the `docs-base` image. Product repositories, such as docker/docker, docker/compose, and so forth use this base image in their local documentation builds.

## How to use it in your repository

This tooling is currently used by:

- [Docker](https://github.com/docker/docker)
- [Docker Compose](https://github.com/docker/compose)
- [Docker Machine](https://github.com/docker/machine)
- [Docker Swarm](https://github.com/docker/swarm)
- [Docker Swarm](https://github.com/docker/distribution)

So there are working examples you can compare with.

Each project uses a documentation specific `Dockerfile` to import the markdown
files and images into the Docker image's `/docs/source` directory.

The repositories with a `Makefile` will build using `make docs`, the others have
either a `script/docs` or `docs/build.sh` script to build a preview of their local documentation.
