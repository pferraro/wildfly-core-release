#!/bin/bash

docker run \
  --memory=4G \
	-v ~/.m2/settings.xml:/home/wfcore/.m2/settings.xml \
	-v wfcore-release-maven-repo:/home/wfcore/.m2 \
	-v wfcore-release-checkouts:/home/wfcore/checkouts \
	-v ~/.gitconfig:/home/wfcore/.gitconfig \
	-v ~/.ssh:/home/wfcore/.ssh \
	-it jmesnil/wildfly-core-release \
  bash
