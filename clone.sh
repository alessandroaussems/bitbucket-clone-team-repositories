#!/usr/bin/env bash

# Get all team repositories
curl -g "https://$1:$2@api.bitbucket.org/2.0/repositories/$3?pagelen=100" -o repos.json

# Get all the clone urls (0 = https / 1 = ssh)
jq -r ".values[] | .links.clone[1].href" repos.json > repos.txt

# Clone all the repos
  for repo in `cat repos.txt`
  do
    echo "Cloning" $repo
    git clone $repo
  done

# Cleanup
rm -rf repos.json
rm -rf repos.txt

