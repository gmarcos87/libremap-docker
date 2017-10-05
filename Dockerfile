# Use an elecnix geocouch as a parent image
FROM elecnix/geocouch:latest

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Rpdate the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

# NVM environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.11.4

# Install NVM
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# Install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# Add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Install Grunt
RUN npm install -g grunt-cli

# Get libremap-api
RUN git clone https://github.com/libremap/libremap-api.git
WORKDIR '/libremap-api'
RUN npm install

# Copy local config
ADD ./couch.json ./

# Install libremap-api
CMD grunt push --couch docker

# Time to clean up
WORKDIR /
RUN rm -rf /libremap-api

RUN apt-get remove curl -y\
    && apt-get autoclean

RUN rm -rf $NVM_DIR ~/.npm ~/.nvm

EXPOSE 5984
