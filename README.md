# Docker image for the pre-commit project

This image has the dependencies installed for many of the [supported hooks](http://pre-commit.com/hooks.html)
in the [pre-commit](http://pre-commit.com/) project.

The intended use is to run the python 'pre-commit' executable in a Docker container that contains all
of the required dependencies ahead of time in order to speed up developer on-boarding of the tool.

## Usage

If you just want to use the pre-built image you can find it on the Docker Hub:

[https://hub.docker.com/r/calthorpeanalytics/pre-commit/](https://hub.docker.com/r/calthorpeanalytics/pre-commit/)

or via

    docker run calthorpeanalytics/pre-commit --help

The `Makefile` contains several helper commands.

To generate a new `.pre-commit-config.yaml` file in order to create a new Docker image:

    make yaml

To build a new Docker image:

    make build

To do both in one go:

    make all
