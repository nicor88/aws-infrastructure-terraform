variable "project_name" {}
variable "stage" {}
variable "base_cidr_block" {}
variable "availability_zones" {
  type    = "list"
}

resource "aws_vpc" "vpc" {
  cidr_block       = "${var.base_cidr_block}/16"

  enable_dns_support = "true"
  enable_dns_hostnames  = "true"

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "${var.project_name}-public-route"
  }
}
