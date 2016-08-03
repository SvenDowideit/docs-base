FROM docs/source:v1.12
MAINTAINER Docker Docs <docs@docker.com>

# update the open source repositories that are used to make up the docs
RUN mkdir /oss
RUN git clone --depth 1 https://github.com/docker/compose /oss/compose \
	&& rm -rf /docs/content/compose/ \
	&& cp -r /oss/compose/docs /docs/content/compose

RUN git clone --depth 1 https://github.com/docker/distribution /oss/distribution \
	&& rm -rf /docs/content/registry \
	&& cp -r /oss/distribution/docs /docs/content/registry

RUN git clone --depth 1 https://github.com/docker/docker /oss/docker \
	&& rm -rf /docs/content/engine \
	&& cp -r /oss/docker/docs /docs/content/engine

RUN git clone --depth 1 https://github.com/docker/kitematic /oss/kitematic \
	&& rm -rf /docs/content/kitematic \
	&& cp -r /oss/kitematic/docs /docs/content/kitematic

RUN git clone --depth 1 https://github.com/docker/machine /oss/machine \
	&& rm -rf /docs/content/machine \
	&& cp -r /oss/machine/docs /docs/content/machine

RUN git clone --depth 1 https://github.com/docker/notary /oss/notary \
	&& rm -rf /docs/content/notary \
	&& cp -r /oss/notary/docs /docs/content/notary

RUN git clone --depth 1 https://github.com/docker/opensource /oss/opensource \
	&& rm -rf /docs/content/opensource \
	&& cp -r /oss/opensource/docs /docs/content/opensource

RUN git clone --depth 1 https://github.com/docker/swarm /oss/swarm \
	&& rm -rf /docs/content/swarm \
	&& cp -r /oss/swarm/docs /docs/content/swarm

RUN git clone --depth 1 https://github.com/docker/toolbox /oss/toolbox \
	&& rm -rf /docs/content/toolbox \
	&& cp -r /oss/toolbox/docs /docs/content/toolbox
