#!/bin/sh

cd ${CODEBUILD_SRC_DIR}/aws

CURRENT_DIR=`pwd`
for FILE in $(git diff HEAD^..HEAD --diff-filter=AM --name-only -- "*.tf") ; do
  cd $(dirname ${FILE}); cd ../
  RES=`\find . -name "*.yaml" -maxdepth 1 2> /dev/null`
  if [ -n "$RES" ]; then
    terraform init -input=false -no-color
    terraform plan -input=false -no-color | \
    tfnotify --config ${CODEBUILD_SRC_DIR}/tfnotify.yml plan --message "$(date)
    cd $CURRENT_DIR
  elif [ -z "$RES" ]; then
    echo "tf files nothing"
    cd $CURRENT_DIR
  fi
done

# for FILE in $(git diff ${MERGE_BASE} HEAD --diff-filter=AM --name-only -- "*.tf") ; do
#     RES=`\find . -name "*.tf" -maxdepth 1 2> /dev/null`
#     if [ -n "$RES" ]; then
#         terraform init -input=false -no-color
#         terraform plan -input=false -no-color | \
#         tfnotify --config ${CODEBUILD_SRC_DIR}/tfnotify.yml plan --message "$(date)
#     elif [ -z "$RES" ]; then
#         echo "tf file nothing"
#         cd ${CODEBUILD_SRC_DIR}
#     fi
# done