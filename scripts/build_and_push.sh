#!/bin/sh
safe_execute() {
  command=$1

  >&2 echo "execute: $command"
  sh -c "$command"
  if [ $? -ne 0 ]; then
    >&2 echo "Failed to execute: $command"
    exit 1
  fi
}

main() {
  # build image
  safe_execute "docker build -f ./apps/app1/Dockerfile -t app1:0.0.1 ."
  safe_execute "docker image ls"

  echo "Build and push image is completed."
  exit 0
}

main