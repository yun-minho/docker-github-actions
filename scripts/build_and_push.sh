#!/bin/sh
TARGET_APP=(
    app1 
    app2
)

VERSION=$1

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
  for APP in "${TARGET_APP[@]}"; do
    # build image
    safe_execute "docker build -f ./apps/$APP/Dockerfile -t $APP:$VERSION ."

    # set tag for push
    # safe_execute "docker tag $APP:$VERSION dwango-docker.jfrog.io/yun/actions-test/$APP:$VERSION"

    # push to artifactory
    safe_execute "docker push dwango-docker.jfrog.io/yun/actions-test/$APP:$VERSION"
  done
  
  echo "Build and push image is completed."
  exit 0
}

main
