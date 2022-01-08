package tags_validation

minimum_tags = {"Name"}

tags_contain_proper_keys(tags) {
    keys := {key | tags[key]}
    leftover := minimum_tags - keys
    leftover == set()
}