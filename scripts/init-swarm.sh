#!/bin/bash
# Init swarm
docker swarm init
docker network create -d overlay agent_network
docker network create -d overlay traefik