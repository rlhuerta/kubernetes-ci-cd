#!/bin/bash

#Retrieve the latest git commit hash
BUILD_TAG=`git rev-parse --short HEAD`

#Build the docker image
docker build -t 127.0.0.1:30400/puzzle:latest -f /home/rthuerta/kubernetes-ci-cd/applications/puzzle/Dockerfile applications/puzzle

#Setup the proxy for the registry
docker stop socat-registry; docker rm socat-registry; docker run -d -e "REG_IP=`minikube ip`" -e "REG_PORT=30400" --name socat-registry -p 30400:5000 socat-registry

echo "5 second sleep to make sure the registry is ready"
sleep 5;

#Push the images
docker push 127.0.0.1:30400/puzzle:latest

#Stop the registry proxy
docker stop socat-registry

# Create the deployment and service for the puzzle server aka puzzle
sed 's#127.0.0.1:30400/puzzle:latest#127.0.0.1:30400/puzzle:latest#' /home/rthuerta/kubernetes-ci-cd/applications/puzzle/k8s/deployment.yaml | kubectl apply -f -

