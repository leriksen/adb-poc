locals {
  library_data = jsondecode(file("${path.module}/library_config.json"))
}

data databricks_clusters all {}

locals {
  pypi_all_libs = toset(flatten([
    for cluster in data.databricks_clusters.all.ids: [
      for library in local.library_data.all.pypi: format("%s::%s::%s", cluster, library.package, try(library.repo, "null"))
    ]
  ]))

  cran_all_libs = toset(flatten([
    for cluster in data.databricks_clusters.all.ids: [
      for library in local.library_data.all.cran: format("%s::%s::%s", cluster, library.package, try(library.repo, "null"))
    ]
  ]))

  maven_all_libs = toset(flatten([
    for cluster in data.databricks_clusters.all.ids: [
      for library in local.library_data.all.maven: format("%s::%s::%s", cluster, library.package, try(join("|", library.exclusions), "null"))
    ]
  ]))

  jar_all_libs = toset(flatten([
    for cluster in data.databricks_clusters.all.ids: [
      for library in local.library_data.all.jar: format("%s::%s", cluster, library.dbfs_path)
    ]
  ]))

  whl_all_libs = toset(flatten([
    for cluster in data.databricks_clusters.all.ids: [
      for library in local.library_data.all.whl: format("%s::%s", cluster, library.dbfs_path)
    ]
  ]))

  egg_all_libs = toset(flatten([
    for cluster in data.databricks_clusters.all.ids: [
      for library in local.library_data.all.egg: format("%s::%s", cluster, library.dbfs_path)
    ]
  ]))
}

resource databricks_library pypi_all {
  depends_on = [
    databricks_cluster.autoscaling
  ]

  for_each = local.pypi_all_libs

  cluster_id = element(split("::", each.value), 0)

  pypi {
    package = element(split("::", each.value), 1)
    repo    = element(split("::", each.value), 2) == "null"  ? null : element(split("::", each.value), 2)
  }
}

resource databricks_library cran_all {
  depends_on = [
    databricks_cluster.autoscaling
  ]

  for_each = local.cran_all_libs

  cluster_id = element(split("::", each.value), 0)

  cran {
    package = element(split("::", each.value), 1)
    repo    = element(split("::", each.value), 2) == "null"  ? null : element(split("::", each.value), 2)
  }
}

resource databricks_library maven_all {
  depends_on = [
    databricks_cluster.autoscaling
  ]

  for_each = local.maven_all_libs

  cluster_id = element(split("::", each.value), 0)

  cran {
    coordinates = element(split("::", each.value), 1)
    exclusions  = element(split("::", each.value), 2) == "null"  ? null : split("|", element(split("::", each.value), 2))
  }
}

resource databricks_library jar_all {
  depends_on = [
    databricks_cluster.autoscaling,
    # expects the DBFS path have already been added
    databricks_dbfs_file.user_files
  ]

  for_each = local.jar_all_libs

  cluster_id = element(split("::", each.value), 0)
  # this is a dbfs path
  jar        = element(split("::", each.value), 1)
}

resource databricks_library whl_all {
  depends_on = [
    databricks_cluster.autoscaling,
    # expects the DBFS path have already been added
    databricks_dbfs_file.user_files
  ]

  for_each = local.whl_all_libs

  cluster_id = element(split("::", each.value), 0)
  # this is a dbfs path
  whl        = element(split("::", each.value), 1)
}

resource databricks_library egg_all {
  depends_on = [
    databricks_cluster.autoscaling,
    # expects the DBFS path have already been added
    databricks_dbfs_file.user_files
  ]

  for_each = local.egg_all_libs

  cluster_id = element(split("::", each.value), 0)
  # this is a dbfs path
  egg        = element(split("::", each.value), 1)
}
