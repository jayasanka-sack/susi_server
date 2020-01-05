#!/bin/bash
set -e
git config --global push.default simple # we only want to push one branch — master
git fetch --unshallow origin
ssh-keyscan -H $IP >> ~/.ssh/known_hosts
# add repo on vps as a repote
git remote add production ssh://$USER@$IP/home/$USER/susi-server
# push updates
git push -f production HEAD:master
# build and start susi server
ssh $USER@$IP <<EOF
  cd susi-server
  bin/stop.sh
  git submodule update --recursive --remote
  git submodule update --init --recursive
  mkdir -p data/generic_skills/
  touch data/generic_skills/media_discovery
  ./gradlew build

EOF
ssh $USER@$IP <<EOF
  cd susi-server
  bin/start.sh
EOF
