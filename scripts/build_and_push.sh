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
  TARGET_APP=(
    app1 
    app2
  )

  TAG_NAME=$1

  for APP in "${TARGET_APP[@]}"; do
    # build image
    safe_execute "docker build -f ./apps/$APP/Dockerfile -t $APP:$TAG_NAME ."
    safe_execute "docker image ls"
  done
  
  echo "Build and push image is completed."
  exit 0
}

main