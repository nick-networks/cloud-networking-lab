variable "region" {
  description = "AWS region for this lab"
  type        = string
  default     = "us-east-1"
}

variable "lab_name" {
  description = "Lab identifier used in tags"
  type        = string
  default     = "lab-nn"
}
