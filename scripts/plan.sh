#!/bin/sh

cd ${CODEBUILD_SRC_DIR}/terraform
terraform init -input=false -no-color
terraform plan -input=false -no-color | \
tfnotify --config ${CODEBUILD_SRC_DIR}/tfnotify.yml plan --message "$(date)"