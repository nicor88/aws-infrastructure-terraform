resource "aws_security_group" "postgres_public_sg" {
    name = "postgres-sg"
    description = "Allow all the IP to connect to Postgres"
    vpc_id = "${aws_vpc.vpc.id}"

    ingress {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.project_name}-postgres-sg"
    }
}
