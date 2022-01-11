resource "aws_organizations_organization" "my-org" {
    feature_set = "ALL"   
    aws_service_access_principals = [
        "backup.amazonaws.com",
        "sso.amazonaws.com"
    ]
    enabled_policy_types = [ "AISERVICES_OPT_OUT_POLICY" ]
}

resource "aws_organizations_account" "sandbox_account" {
    name = "sandbox"
    email = "tasogare.yukei_0919@me.com"
}