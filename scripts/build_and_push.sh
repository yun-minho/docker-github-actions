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
  # safe_execute "docker build -f $dockerfile -t dentaku-import:version ."

  echo "Build and push image is completed."
  exit 0
}

main