#
# See the top level Makefile in https://github.com/docker/docker for usage.
#
FROM debian:jessie
MAINTAINER Mary Anthony <mary@docker.com> (@moxiegirl)

RUN apt-get update \
	&& apt-get install -y gettext git wget libssl-dev make python-dev python-pip python-setuptools subversion-tools vim-tiny ssed curl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Required to publish the documentation.
# The 1.4.4 version works: the current versions fail in different ways
# TODO: Test to see if the above holds true
RUN pip install awscli==1.4.4 pyopenssl==0.12

# We can go back to using the official version when hugo 0.16 is released with our PR merged.
#ENV HUGO_VERSION 0.16
#RUN curl -sSL https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux_amd64.tar.gz \
#	| tar -v -C /usr/local/bin -xz --strip-components 1 \
#	&& mv /usr/local/bin/hugo_${HUGO_VERSION}_linux_amd64 /usr/local/bin/hugo

# Using a pre-build of hugo 0.16
ENV HUGO_VERSION 0.16-pre3
RUN curl -sSL -o /usr/local/bin/hugo https://github.com/docker/hugo/releases/download/${HUGO_VERSION}/hugo
RUN chmod 755 /usr/local/bin/hugo
RUN /usr/local/bin/hugo version

ADD https://github.com/docker/markdownlint/releases/download/v0.9.5/markdownlint /usr/local/bin/markdownlint
RUN chmod 755 /usr/local/bin/markdownlint

ADD https://github.com/docker/linkcheck/releases/download/v0.3/linkcheck /usr/local/bin/linkcheck
RUN chmod 755 /usr/local/bin/linkcheck


#######################
# Copy the content and theme to the container
#######################
WORKDIR /docs
COPY . /docs
RUN chmod 755 /docs/validate.sh

EXPOSE 8000

# default to validating the docs build
CMD ["/docs/validate.sh"]
