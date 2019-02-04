variable "project_name" {
   default = "nicor"
}

variable "stage" {
   default = "dev"
}

variable "base_cidr_block" {
   default = "10.0.0.0"
}

variable "availability_zones" {
   type    = "list"
   default = ["us-east-1a", "us-east-1b"]
}