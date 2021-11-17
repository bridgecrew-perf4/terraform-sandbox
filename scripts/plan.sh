#!/bin/sh

TARGET_BRANCH=main
MERGE_BASE=`git show-branch --merge-base origin/${TARGET_BRANCH} HEAD`

cd ${CODEBUILD_SRC_DIR}/aws

for FILE in $(git diff ${MERGE_BASE} HEAD --diff-filter=AM --name-only -- "*.tf") ; do
    RES=`\find . -name "*.tf" -maxdepth 1 2> /dev/null`
    if [ -n "$RES" ]; then
        terraform init -input=false -no-color
        terraform plan -input=false -no-color | \
        tfnotify --config ${CODEBUILD_SRC_DIR}/tfnotify.yml plan --message "$(date)
    elif [ -z "$RES" ]; then
        echo "tf file nothing"
        cd ${CODEBUILD_SRC_DIR}
    fi
done