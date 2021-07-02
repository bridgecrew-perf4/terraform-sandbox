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
    buildspec = "buildspec.yml"
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    type            = "LINUX_CONTAINER"
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:3.0"
    privileged_mode = false
  }


}

resource "aws_codebuild_webhook" "tag_release_build_webhook" {
  project_name = aws_codebuild_project.tag_release_build.name

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PULL_REQUEST_CREATED"
    }
  }

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PULL_REQUEST_UPDATED"
    }
  }

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PULL_REQUEST_REOPENED"
    }
  }

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "^refs/tags/v1.0"
    }
  }
}