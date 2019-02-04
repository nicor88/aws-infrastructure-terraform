resource "aws_subnet" "public-subnet-1" {
    vpc_id = "${aws_vpc.vpc.id}"

    cidr_block = "10.0.0.0/24"
    availability_zone =  "${var.availability_zones[0]}"

    map_public_ip_on_launch = true

    tags {
        Name = "${var.project_name}-public-subnet-1"
    }
}

resource "aws_route_table_association" "public-subnet-1-public-route-association" {
    subnet_id = "${aws_subnet.public-subnet-1.id}"
    route_table_id = "${aws_route_table.public-route-table.id}"
}

resource "aws_subnet" "public-subnet-2" {
    vpc_id = "${aws_vpc.vpc.id}"

    cidr_block = "10.0.1.0/24"
    availability_zone =  "${var.availability_zones[1]}"
    map_public_ip_on_launch = true

    tags {
        Name = "${var.project_name}-public-subnet-2"
    }
}

resource "aws_route_table_association" "public-subnet-2-public-route-association" {
    subnet_id = "${aws_subnet.public-subnet-2.id}"
    route_table_id = "${aws_route_table.public-route-table.id}"
}
