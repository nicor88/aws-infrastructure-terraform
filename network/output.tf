output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "subnet_1" {
  value = "${aws_subnet.public-subnet-1.id}"
}

output "subnet_2" {
  value = "${aws_subnet.public-subnet-2.id}"
}

output "postgres_public_sg" {
  value = "${aws_security_group.postgres_public_sg.id}"
}
