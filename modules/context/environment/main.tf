module "globals" {
  source = "../globals"
}

locals {
  env_sub = {
    poc = "NP"
    prd = "P"
  }
}

module "subscription" {
  source = "../subscription"
  subscription = local.env_sub[var.environment]
}



