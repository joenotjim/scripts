#!/bin/bash
# A script to parse the release tags for RKE2 and K3s and print the latest patch release for each minor version

for dist in rancher/rke2 k3s-io/k3s
do
  curl -s https://api.github.com/repos/$dist/git/refs/tags \
  | jq -r '.[].ref' \
  | grep ${dist#*/} \
  | egrep -v 'alpha|beta|rc' \
  | cut --delimiter=/ --fields=3 \
  | sort --version-sort --reverse \
  | uniq --check-chars=5
done
