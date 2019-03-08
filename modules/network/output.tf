output "vpc_id" {
  value = "${aws_vpc.this.id}"
}

output "public_subnet_1" {
  value = "${aws_subnet.public_subnet_1.id}"
}

output "public_subnet_2" {
  value = "${aws_subnet.public_subnet_2.id}"
}

output "public_subnet_3" {
  value = "${aws_subnet.public_subnet_3.id}"
}

output "main_security_group" {
  value = "${aws_security_group.this.id}"
}
