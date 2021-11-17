#!/bin/sh

set -x

if [ ${CODEBUILD_WEBHOOK_TRIGGER} = 'branch/main' ]; then
  ${CODEBUILD_SRC_DIR}/scripts/apply.sh main
# elif [ ${CODEBUILD_WEBHOOK_TRIGGER} = 'branch/develop' ]; then
#   ${CODEBUILD_SRC_DIR}/scripts/apply.sh develop
else
  ${CODEBUILD_SRC_DIR}/scripts/plan.sh
fi