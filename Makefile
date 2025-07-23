# Dockerf project makefile.
.SHELL := bash
MAKEFLAGS += --warn-undefined-variables
mcmas.img ?= mcmas
mcmas.test_dir=/opt/mcmas/examples
mcmas.cli=-v 3 -k -a

include .cmk/compose.mk

$(call docker.import, \
	namespace=docker.mcmas \
	file=Dockerfile img=${mcmas.img})

.PHONY: build docs
__main__: clean init build test

clean: flux.stage/clean
	docker rmi -f ${mcmas.img}

init: flux.stage/init mk.stat docker.stat

build: flux.stage/build docker.mcmas.build

test: flux.stage/test test.outside test.inside 
test.inside: docker.mcmas.dispatch/self.test
test.outside:
	set -x \
	&& docker run mcmas -a -k -v 3 /opt/mcmas/examples/muddy_children.ispl

self.test.list:; find ${mcmas.test_dir} | ${stream.as.log}
self.test: self.test.list \
	self.test/dining_cryptographers \
	self.test/muddy_children \
	self.test/strongly_connected \
	self.test/software_development \
	self.test/simple_card_game
self.test/%:
	${make} io.print.banner/${*}
	mcmas ${mcmas.cli} ${mcmas.test_dir}/${*}.ispl

shell: docker.mcmas.shell


