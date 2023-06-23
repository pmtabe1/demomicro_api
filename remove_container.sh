#!/bin/bash

container_name="demomicro_api_todo"

# Stop the container if it's running
docker stop "$container_name"

# Remove the container
docker rm "$container_name"
