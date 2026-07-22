terraform {
    required_providers {
      databricks = {
        source = "databricks/databricks"
      }
    }
}


provider "databricks" {
  
}



data "databricks_current_user" "me"{

}


output "my_username" {
  value = data.databricks_current_user.me.user_name
}

resource "databricks_directory" "test_folder" {
    path = "/Shared/terraform-test-folder-renamed"
}

resource "databricks_notebook" "my_notebook" {
  path            = "/Shared/terraform-notebook-lesson"
  language        = "PYTHON"
  content_base64  = base64encode("print('hello from terraform')")
}

resource "databricks_job" "my_job" {
  name = "terraform-lesson-job"

  task {
    task_key = "run_notebook"

    notebook_task {
      notebook_path = databricks_notebook.my_notebook.path
    }
  }
}