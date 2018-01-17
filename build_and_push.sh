#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
NAME=videoblocks/selenium-testrunner

docker build -t $NAME $DIR
docker push $NAME
