# Docker documentation theme

Docker uses [the Hugo static generator](http://gohugo.io/overview/introduction/) to convert project Markdown files to a static HTML site. This repository contains the HTML theme and Hugo configuration for building the [the Docker documentation site](https://docs.docker.com).  

Together, the theme and the structure form the `docs-base` image. Each project repository uses this base image to generate localized documentation for review during development. 


## How to use it in your repository

To use this this in your own repository, you need to have `make` installed on your system.  Then, do the following:

1. Create a `docs` subdirectory in your project.

2. Create a `docs/Dockerfile` with the following structure:

        FROM docs-base:hugo
        MAINTAINER YOUR NAME <YOUR_EMAIL> (@yourgithubhandle)

        # to get the git info for this repo
        COPY . /src

        COPY . /docs/content/PROJECTNAME/

        RUN find /docs/content/PROJECTNAME -type f -name "*.md" -exec sed -i.old  -e '/^<!.*metadata]>/g' -e '/^<!.*end-metadata.*>/g' {} \;
        
     The `sed` line in this file removes the Hugo metadata from the content.
     
3. Copy [a Makefile from a sub project](https://github.com/docker/swarm/blob/master/docs/Makefile).

4. Make changes to the content in the project.

5. Commit your changes.

6. In the `PROJECT/docs` directory run the `make docs` command.

        $ make docs
        docker build -t "docs-base:test-tooling" .
        Sending build context to Docker daemon 65.54 kB
        Sending build context to Docker daemon 
        Step 0 : FROM docs-base:hugo
         ---> 353c49564399
        ...snip...
        Successfully built f2c701b7b47b
        docker run --rm -it  -e AWS_S3_BUCKET -e NOCACHE -p 8000:8000 -e DOCKERHOST "docs-base:test-tooling" hugo server --port=8000 --baseUrl=192.168.59.103 --bind=0.0.0.0
        0 of 4 drafts rendered
        0 future content 
        11 pages created
        0 paginator pages created
        0 tags created
        0 categories created
        in 40 ms
        Serving pages from /docs/public
        Web Server is available at http://0.0.0.0:8000/
        Press Ctrl+C to stop
        
7. Open the browser to the root of your docs.

### Example of projects using this image 

- [Docker Engine](https://github.com/docker/docker)
- [Docker Compose](https://github.com/docker/compose)
- [Docker Machine](https://github.com/docker/machine)
- [Docker Swarm](https://github.com/docker/swarm)
- [Docker Distribution](https://github.com/docker/distribution)

## Contribute to this repository

You can contribute to this repository just as would any other Docker repository.  


