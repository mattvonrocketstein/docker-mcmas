[![Build and Push to GHCR](https://github.com/mattvonrocketstein/docker-mcmas/actions/workflows/docker-build-push.yml/badge.svg)](https://github.com/mattvonrocketstein/docker-mcmas/actions/workflows/docker-build-push.yml)

## MCMAS in a Container

MCMAS is a model checker for multi-agent systems that supports temporal epistemic logic.  

MAS descriptions are given by means of programs written in the ISPL language.  ISPL is an agent-based, modular language inspired by interpreted systems, a popular semantics.  It describes things like: agents, groups, environments, states, evolutions, protocols, and fairness.  Temporal logic operators include `AG`/`EF`/`AX`. Epistemic logic supports `K`/`GK`/`GCK`/`DK`.  

For MCMAS source and manual, see the [official page at SAIL](https://sail.doc.ic.ac.uk/software/mcmas/) or this [unofficial mirror](https://github.com/mattvonrocketstein/mcmas).

This container is used as part of [py-mcmas](https://github.com/mattvonrocketstein/py-mcmas).

## Usage

```bash 
# Pull it 
docker pull ghcr.io/mattvonrocketstein/mcmas:v1.3.0

# Run one of the examples that ships with engine
docker run ghcr.io/mattvonrocketstein/mcmas:v1.3.0 -v 3 -a -k /opt/mcmas/examples/muddy_children.ispl

# Use volume-mount to access host files
docker run -v `pwd`:/workspace -w/workspace ghcr.io/mattvonrocketstein/mcmas:v1.3.0 -v 3 -a -k my.ispl
```

## Development

```bash

# Build, exercise, and test the container, then drop into debugging shell
make clean build test shell
```