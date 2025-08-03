variable "role_name" {
  type        = string
  description = "Name of the IAM role"
}

variable "assume_role_policy" {
  type        = string
  description = "The assume role policy JSON"
}

variable "policy_document" {
  type        = string
  description = "IAM policy document in JSON"
  default     = ""
}

variable "create_policy" {
  type        = bool
  description = "Whether to create and attach a custom policy"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags for the IAM role"
  default     = {}
}
