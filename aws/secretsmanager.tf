data "aws_kms_secrets" "secrets" {
    secret {
        name = "secrets"
        payload = file("./secrets/secrets.yaml.encrypted")
    }
}

resource "aws_secretsmanager_secret" "hoge_secrets" {
    name = "hoge-secrets"
    recovery_window_in_days = 30
}

locals {
    hoge_secrets = yamldecode(data.aws_kms_secrets.secrets.plaintext["secrets"])
}


resource "aws_secretsmanager_secret_version" "hoge_secrets_detail" {
    secret_id = aws_secretsmanager_secret.hoge_secrets.id
    version_stages = ["AWSCURRENT"]
    secret_string = jsonencode({
        username = local.hoge_secrets.username
        password = local.hoge_secrets.password
        dbhost = local.hoge_secrets.dbhost
        dbname	= local.hoge_secrets.dbname
        dbhost_replica = local.hoge_secrets.dbhost_replica
        hoge_token = local.hoge_secrets.hoge_token
    })
}