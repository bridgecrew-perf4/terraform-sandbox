variable "datadog_api_key" {}
variable "datadog_app_key" {}

terraform {
  required_providers {
    datadog = {
        source = "Datadog/datadog"
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}


resource "datadog_monitor" "cpu_monitor" {
    name = "cpu monitor"
    type = "metric alert"
    message = "cpu alert"
    query = "max(last_5m):100 - avg:system.cpu.idle{*} by {host,name} > 90"

    monitor_thresholds {
        ok = 70
        warning = 80
        critical = 90
    }
  
}