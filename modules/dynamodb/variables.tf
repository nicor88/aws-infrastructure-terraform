variable "aws_account_id" {}

variable "table_name" {}

variable "stage" {}

variable "primary_key" {}

variable "primary_key_type" {}

variable "sort_key" {
  default = ""
}

variable "attributes" {
  description = ""
  type        = "list"
  default     = []
}

variable "enable_recovery" {}

variable "read_capacity" {}

variable "read_max_capacity" {}

variable "read_percentage_scaling" {}

variable "read_scale_in_cooldown" {}

variable "read_scale_out_cooldown" {}

variable "write_capacity" {}

variable "write_max_capacity" {}

variable "write_percentage_scaling" {}

variable "write_scale_in_cooldown" {}

variable "write_scale_out_cooldown" {}
