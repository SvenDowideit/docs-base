#
# See the top level Makefile in https://github.com/docker/docker for usage.
#
FROM ubuntu:16.04
MAINTAINER Docker Docs <docs@docker.com>

RUN apt-get update \
	&& apt-get install -y gettext git wget libssl-dev make python-dev python-pip python-setuptools subversion-tools vim-tiny ssed curl libffi-dev awscli \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8000

# We can go back to using the official version when hugo 0.16 is released with our PR merged.
#ENV HUGO_VERSION 0.16
#RUN curl -sSL https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux_amd64.tar.gz \
#	| tar -v -C /usr/local/bin -xz --strip-components 1 \
#	&& mv /usr/local/bin/hugo_${HUGO_VERSION}_linux_amd64 /usr/local/bin/hugo

# Using a pre-build of hugo 0.16
ENV HUGO_VERSION 0.16-pre5
RUN curl -sSL -o /usr/local/bin/hugo https://github.com/docker/hugo/releases/download/${HUGO_VERSION}/hugo \
 && chmod 755 /usr/local/bin/hugo \
 && /usr/local/bin/hugo version

RUN curl -sSL -o /usr/local/bin/markdownlint https://github.com/docker/markdownlint/releases/download/v0.9.5/markdownlint \
 && chmod 755 /usr/local/bin/markdownlint

RUN curl -sSL -o /usr/local/bin/linkcheck https://github.com/docker/linkcheck/releases/download/2016-07-11/linkcheck \
 && chmod 755 /usr/local/bin/linkcheck


#######################
# Copy the content and theme to the container
#######################
WORKDIR /docs

# default to validating the docs build
CMD ["/docs/validate.sh"]
COPY validate.sh /docs
RUN chmod 755 /docs/validate.sh

COPY . /docs
