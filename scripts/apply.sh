#!/bin/sh

CURRENT_DIR=`pwd`
MESSAGE=$(git log ${CODEBUILD_SOURCE_VERSION} -1 --pretty=format:"%s")
CODEBUILD_SOURCE_VERSION=$(echo ${MESSAGE} | cut -f4 -d' ' | sed 's/#/pr\//')

# terraform init -input=false -no-color
# terraform apply -input=false -no-color -auto-approve | \
# tfnotify --config ${CODEBUILD_SRC_DIR}/tfnotify.yml apply --message "$(date)"

for FILE in $(git diff origin/main --diff-filter=AM --name-only -- "*.tf" --relative –no-prefix aws) ; do
  cd $(dirname ${FILE})
  RES=`\find . -name "*.tf" -maxdepth 1 2> /dev/null`
  if [ -n "$RES" ]; then
    terraform init -input=false -no-color
    terraform apply -input=false -no-color -auto-approve | \
    tfnotify --config ${CODEBUILD_SRC_DIR}/tfnotify.yml apply --message "$(date)"
    cd $CURRENT_DIR
  elif [ -z "$RES" ]; then
    echo "tf files nothing"
    cd $CURRENT_DIR
  fi
done