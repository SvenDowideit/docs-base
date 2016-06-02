FROM docs/base:latest
MAINTAINER Sven Dowideit <SvenDowideit@home.org.au> @SvenDowideit

# Get all the open source repositories that are used to make up the docs
RUN mkdir /oss
RUN git clone --depth 1 https://github.com/docker/compose /oss/compose \
	&& cp -r /oss/compose/docs /docs/content/compose

RUN git clone --depth 1 https://github.com/docker/distribution /oss/distribution \
	&& cp -r /oss/distribution/docs /docs/content/registry

RUN git clone --depth 1 https://github.com/docker/docker /oss/docker \
	&& cp -r /oss/docker/docs /docs/content/engine

RUN git clone --depth 1 https://github.com/docker/kitematic /oss/kitematic \
	&& cp -r /oss/kitematic/docs /docs/content/kitematic

RUN git clone --depth 1 https://github.com/docker/machine /oss/machine \
	&& cp -r /oss/machine/docs /docs/content/machine

RUN git clone --depth 1 https://github.com/docker/notary /oss/notary \
	&& cp -r /oss/notary/docs /docs/content/notary

RUN git clone --depth 1 https://github.com/docker/opensource /oss/opensource \
	&& cp -r /oss/opensource/docs /docs/content/opensource

RUN git clone --depth 1 https://github.com/docker/swarm /oss/swarm \
	&& cp -r /oss/swarm/docs /docs/content/swarm

RUN git clone --depth 1 https://github.com/docker/toolbox /oss/toolbox \
	&& cp -r /oss/toolbox/docs /docs/content/toolbox
