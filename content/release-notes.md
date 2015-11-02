+++
title = "Docker Release Notes"
description = "Release notes for Docker 1.x."
keywords = ["docker, documentation, about, technology, understanding,  release"]
[menu.main]
parent = "mn_about"
+++

# Release notes
(2015-08-11)

On August 11, 2015 Docker released Docker Engine (1.8.0) and on August 12, 2015
(1.8.1). On August 11, 2015 Docker Compose 1.4.0, Docker Swarm 0.4.0, and Docker Machine 0.4.0 to
the public.

### Docker Engine 1.8.3
(12 October 2015)

As part of our ongoing security efforts, <a href="http://blog.docker.com/2015/10/security-release-docker-1-8-3-1-6-2-cs7"
target="_blank">a vulnerability was discovered</a> that affects the way content
is stored and retrieved within the Docker Engine. Today we are releasing a
security update that fixes this issue. The <a href="https://github.com/docker/docker/blob/master/CHANGELOG.md#183-2015-10-12"
target="_blank">change log for Docker Engine 1.8.3</a> has a complete list of
all the changes incorporated into the release.

We recommend that users upgrade to Docker Engine 1.8.3. If you are unable to
upgrade right away, remember to only pull content from trusted sources.

To keep up to date on all the latest Docker Security news, make sure you review our [Security page](http://www.docker.com/docker-security), subscribe to our
mailing list, or find us in #docker-security.

## Docker Engine 1.8.0, 1.8.1, 1.8.2

For a complete list of engine patches, fixes, and other improvements, see the
[release page on GitHub](https://github.com/docker/docker/releases). You can also review the project changelog for details :

* <a href="https://github.com/docker/docker/blob/master/CHANGELOG.md#182-2015-09-10">1.8.2</a>
* <a href="https://github.com/docker/docker/blob/master/CHANGELOG.md#181-2015-08-12">1.8.1</a>
* <a href="https://github.com/docker/docker/blob/master/CHANGELOG.md#180-2015-08-11">1.8.0</a>


Beginning with this release, Docker Engine maintains an on-going experimental
build. To learn more about the build and try it for yourself, see [the
experimental
directory](https://github.com/docker/docker/tree/master/experimental) in the
Docker project.

## Docker Swarm 0.4.0

You'll find <a href="https://github.com/docker/swarm/blob/v0.4.0/CHANGELOG.md">
a changelog in the project repository</a> for a list of changes. You'll find the
[release for download on
GitHub](https://github.com/docker/swarm/releases/tag/v0.4.0).

## Docker Compose 1.4.0, 1.4.1, 1.4.2

For a complete list of compose patches, fixes, and other improvements, see <a
href="https://github.com/docker/compose/blob/master/CHANGELOG.md">the changelog in the project repository</a>. The project also makes a [set of release
notes](https://github.com/docker/compose/releases) on the project.


## Docker Machine 0.4.0

You'll find the [release for download on
GitHub](https://github.com/docker/machine/releases). This page also includes a
list of the features provided in the release. For a complete list of machine
changes, see <a
href="https://github.com/docker/machine/blob/v0.4.0/CHANGELOG.md"> the changelog
in the project repository</a>.

Beginning with this release, Docker Machine provides you with a set of
experimental features to try out.  To learn more about the build and try it for
yourself, see [the experimental directory in the Docker
Machine project](https://github.com/docker/machine/tree/master/experimental).
