#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

WHEREAMI=`dirname "${0}"`

docker build -t ${DOCKER_ORG}/${DOCKER_IMAGE_NAME}:${CIRCLE_BRANCH} ${WHEREAMI}
docker tag ${DOCKER_ORG}/${DOCKER_IMAGE_NAME}:${CIRCLE_BRANCH} ${DOCKER_HUB}/${DOCKER_ORG}/${DOCKER_IMAGE_NAME}:${CIRCLE_BRANCH}

set +o xtrace
echo -n "${DOCKER_PASSWORD}"  | docker login -u="${DOCKER_USERNAME}" --password-stdin ${DOCKER_HUB}
set -o xtrace

docker push ${DOCKER_HUB}/${DOCKER_ORG}/${DOCKER_IMAGE_NAME}:${CIRCLE_BRANCH}
