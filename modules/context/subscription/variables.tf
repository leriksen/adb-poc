variable "subscription" {
  type        = string
  description = "description"
  validation {
    condition     = contains(["NP"], var.subscription)
    error_message = "The subscription must be one of [NP]"
  }
}
