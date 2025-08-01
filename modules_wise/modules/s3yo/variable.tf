# S3 Bucket
variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "my-s3-bucket"
}
variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}
variable "tags" {
  description = "Additional tags for the S3 bucket"
  type        = map(string)
  default     = {}
}

# S3 Bucket Versioning
variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

# S3 Bucket Server-side Encryption
variable "enable_encryption" {
  description = "Enable server-side encryption"
  type        = bool
  default     = true
}
