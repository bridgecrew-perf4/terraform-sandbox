module "continuous_apply_codebuild_role" {
  source     = "./module/iam"
  name       = "tag-release-test-role"
  identifier = "codebuild.amazonaws.com"
  policy     = data.aws_iam_policy.administrator_access.policy
}

data "aws_iam_policy" "administrator_access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_codebuild_project" "tag_release_build" {
  name         = "tag-release-test"
  service_role = module.continuous_apply_codebuild_role.iam_role_arn

  source {
    type      = "GITHUB"
    location  = "https://github.com/tasogare0919/apprunner-express-app"
    buildspec = <<-EOT
     version: 0.2
     
     env:
       git-credential-helper: yes
     
     phases:
       install:
         runtime-versions:
           nodejs: 12
         commands:
           - echo Checkout tags
           - git fetch --tags
           - |
             if [ "$RECOVEY_TAG_VERSION" = "" ]; then
               git checkout $(git describe --tags --abbrev=0)
             else
               git checkout $RECOVEY_TAG_VERSION
             fi
    EOT
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    modes = [
      "LOCAL_DOCKER_LAYER_CACHE"
    ]
    type = "LOCAL"
  }

  environment {
    type            = "LINUX_CONTAINER"
    compute_type    = "BUILD_GENERAL1_MEDIUM"
    image           = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    privileged_mode = true

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.region
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.account
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = "simple-express-repository"
    }

    environment_variable {
      name  = "UPLOAD_BUCKET_NAME"
      type  = "PLAINTEXT"
      value = "s3tada-bucket"
    }
    environment_variable {
       name  = "TRIVY_VERSION"
       type  = "PLAINTEXT"
       value = "0.19.2"
    }

  }


}

# resource "aws_codebuild_webhook" "tag_release_build_webhook" {
#   project_name = aws_codebuild_project.tag_release_build.name

#   filter_group {
#     filter {
#       type    = "EVENT"
#       pattern = "PULL_REQUEST_CREATED"
#     }
#   }

#   filter_group {
#     filter {
#       type    = "EVENT"
#       pattern = "PULL_REQUEST_UPDATED"
#     }
#   }

#   filter_group {
#     filter {
#       type    = "EVENT"
#       pattern = "PULL_REQUEST_REOPENED"
#     }
#   }

#   filter_group {
#     filter {
#       type    = "EVENT"
#       pattern = "PUSH"
#     }

#     filter {
#       type    = "HEAD_REF"
#       pattern = "^refs/tags/v*"
#     }
#   }
# }