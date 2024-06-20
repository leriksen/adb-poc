variable "environment" {
  description = "Context for the environment we are deploying to"
  type = string
  validation {
    condition     = contains(["poc" ], var.environment)
    error_message = "The environment must be one of [poc]"
  }
}