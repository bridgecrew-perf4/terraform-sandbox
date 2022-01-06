#!/bin/sh
CURRENT_DIR=`pwd`
for FILE in $(git diff origin/main --diff-filter=AM --name-only -- "*.tf" --relative –no-prefix aws) ; do
  cd $(dirname ${FILE})
  RES=`\find . -name "*.tf" -maxdepth 1 2> /dev/null`
  if [ -n "$RES" ]; then
    terraform init -input=false -no-color
    terraform plan -input=false -no-color | \
    tfnotify --config ${CODEBUILD_SRC_DIR}/tfnotify.yml plan --message "$(date)"
    cd $CURRENT_DIR
  elif [ -z "$RES" ]; then
    echo "tf files nothing"
    cd $CURRENT_DIR
  fi
done