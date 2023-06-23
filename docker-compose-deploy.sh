#!/bin/bash

COMPOSE_PROJECT_NAME="demomicro_api"  # Replace with your Docker Compose project name

# Check if the project is running
if docker-compose ps | grep -q "$COMPOSE_PROJECT_NAME"; then
  # Project is running, stop it
  docker-compose down
fi

# Start the project
docker-compose up --build -d

