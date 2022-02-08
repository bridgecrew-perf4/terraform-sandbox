resource "aws_s3_bucket" "test" {
    bucket = "my-tf-test-${var.account}"

    tags = {
        Name = "my-tf-test-${var.account}"
        confidentiality = "confidential"
    }
}

