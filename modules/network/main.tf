

resource "aws_vpc" "this" {
  cidr_block       = "${var.vpc_cidr_block}"

  enable_dns_support = "true"
  enable_dns_hostnames  = "true"

  tags = {
    Name = "${var.project}-${var.stage}-vpc"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = "${aws_vpc.this.id}"

  tags = {
    Name = "${var.project}-${var.stage}-igw"
  }
}

resource "aws_route_table" "this_public_route_table" {
  vpc_id = "${aws_vpc.this.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.this.id}"
  }

  tags = {
    Name = "${var.project}-${var.stage}-public-route"
  }
}

resource "aws_subnet" "public_subnet_1" {
    vpc_id = "${aws_vpc.this.id}"

    cidr_block = "${cidrhost(var.vpc_cidr_block,256 * 1)}/24"
    availability_zone =  "${var.availability_zones[0]}"

    map_public_ip_on_launch = true

    tags {
        Name = "${var.project}-${var.stage}-public-1"
    }
}

resource "aws_route_table_association" "public_subnet_1_route_table_association" {
    subnet_id = "${aws_subnet.public_subnet_1.id}"
    route_table_id = "${aws_route_table.this_public_route_table.id}"
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id = "${aws_vpc.this.id}"

    cidr_block = "${cidrhost(var.vpc_cidr_block,256 * 2)}/24"
    availability_zone =  "${var.availability_zones[1]}"

    map_public_ip_on_launch = true

    tags {
        Name = "${var.project}-${var.stage}-public-2"
    }
}

resource "aws_route_table_association" "public_subnet_2_route_table_association" {
    subnet_id = "${aws_subnet.public_subnet_2.id}"
    route_table_id = "${aws_route_table.this_public_route_table.id}"
}

resource "aws_subnet" "public_subnet_3" {
    vpc_id = "${aws_vpc.this.id}"

    cidr_block = "${cidrhost(var.vpc_cidr_block,256 * 3)}/24"
    availability_zone =  "${var.availability_zones[1]}"

    map_public_ip_on_launch = true

    tags {
        Name = "${var.project}-${var.stage}-public-3"
    }
}

resource "aws_route_table_association" "public_subnet_3_route_table_association" {
    subnet_id = "${aws_subnet.public_subnet_3.id}"
    route_table_id = "${aws_route_table.this_public_route_table.id}"
}

# TODO add private routing tables
# TODO add 3 private subnets
# TODO add nat gateway

resource "aws_security_group" "this" {
    name = "${var.project}-${var.stage}-main-sg"
    description = "Allow only outbound connections"
    vpc_id = "${aws_vpc.this.id}"

    # ingress {
    #     from_port   = 5432
    #     to_port     = 5432
    #     protocol    = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.project}-${var.stage}-main-sg"
    }
}
