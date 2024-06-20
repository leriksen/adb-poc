provider "databricks" {
  host                        = data.azurerm_databricks_workspace.adb.workspace_url
  azure_workspace_resource_id = data.azurerm_databricks_workspace.adb.id
}

locals {
  cluster_data = jsondecode(file("${path.module}/cluster_config.json"))
}

resource databricks_cluster autoscaling {
  for_each = lookup(local.cluster_data, "autoscaling")

  cluster_name            = each.key
  node_type_id            = each.value.node_type_id
  spark_version           = each.value.spark_version
  autotermination_minutes = 20
  autoscale {
    min_workers = each.value.autoscale.min_workers
    max_workers = each.value.autoscale.max_workers
  }
}