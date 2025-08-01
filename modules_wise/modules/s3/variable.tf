variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "enable_versioning" {
  type        = bool
  default     = false
  description = "Enable versioning for the bucket"
}

variable "enable_encryption" {
  type        = bool
  default     = false
  description = "Enable server-side encryption"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the bucket"
}