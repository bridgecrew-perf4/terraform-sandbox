variable "github_owner" {
  description = "github owner name"
  default = "tasogare0919"
}
variable "github_oidc_repo_names" {
  description = "set of github_owner/repository_name"
  type        = set(string)
  default = [ "container-era-go" ]
}
