variable "account" {
  default = "130459222683"
}

variable "spot_instance_ami" {
  default = "ami-03bbe60df80bdccc0"
}

variable "gp2_volume_size" {
  default = 50
}

variable "spot_target_capacity" {
  default = 1
}

variable "region" {
  default = "ap-northeast-1"
}

variable "env" {
  type = string
}

variable "elasticsearch_config" {
  type = object({
    region                        = string
    elasticsearch_version         = string
    instance_type                 = string
    instance_count                = number
    dedicated_master_type         = string
    availability_zone_count       = number
    volume_size                   = number
    automated_snapshot_start_hour = number
    iam_service_linked_role       = number
  })
}