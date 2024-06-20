terraform {
  required_version = "~>1.4.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.47.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "2.36.0"
    }

    databricks = {
      source = "databricks/databricks"
      version = "1.15.0"
    }

    external = {
      source = "hashicorp/external"
      version = "2.3.1"
    }

    null = {
      source = "hashicorp/null"
      version = "3.2.1"
    }
  }

  backend azurerm {}
}
