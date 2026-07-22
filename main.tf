terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.0"
    }
  }
}

provider "databricks" {}

data "databricks_current_user" "me" {}

output "my_username" {
  value = data.databricks_current_user.me.user_name
}