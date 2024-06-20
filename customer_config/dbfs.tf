locals {
  library_config = jsondecode(file("${path.module}/dbfs_config.json"))
}

resource databricks_dbfs_file user_files {
  for_each = local.library_config

  source = "${path.module}/${each.value.source}"
  path   = each.value.path
}