# OSS projects base image

This image adds the OSS project's documentation to facilitate faster documentation testing,
both by the writers, and the Jenkins jobs.

To use this image to build your project's documentation, add a `docs/Dockerfile` that looks
like the following example from the `docker/machine` project.

```
FROM docs/base:oss

ENV PROJECT=machine

# To get the git info for this repo
COPY . /src
RUN rm -r /docs/content/$PROJECT/
COPY . /docs/content/$PROJECT/
```
