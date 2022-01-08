package tags_validation


test_tags_contain_proper_keys {
    tags := { "Name":"my-tf-test-${var.account}"}
    tags_contain_proper_keys(tags)
}
