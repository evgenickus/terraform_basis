variable "account_id" {
  description = "basis account id"
  type        = number
  sensitive   = true
}

variable "gid" {
  description = "basis account id"
  type        = number
  sensitive   = true
}

variable "app_id" {
  description = "app id"
  type        = string
  sensitive   = true
}

variable "app_secret" {
  description = "app key"
  type        = string
  sensitive   = true
}