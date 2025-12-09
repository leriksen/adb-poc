terraform {
  required_version = "~>1.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>4.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "~>3.0"
    }

    databricks = {
      source = "databricks/databricks"
      version = "~>1.0"
    }

    external = {
      source = "hashicorp/external"
      version = "~>2.0"
    }

    null = {
      source = "hashicorp/null"
      version = "~>3.0"
    }
  }

  backend "local" {
    path = "./terraform.tfstate"
  }
}
