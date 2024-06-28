variable "bucket_name" {
  description = "The bucket name where the static website will be hosted."
  type        = string
  default = "gudy-bucket"
}

variable "default_document" {
  description = "The web app's default document to be served."
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "The web app's default error document."
  type        = string
  default     = "error.html"
}
