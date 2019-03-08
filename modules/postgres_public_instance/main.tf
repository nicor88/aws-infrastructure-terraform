
# TODO replace with a password from secret manager
resource "random_string" "password" {
    length = 32
    upper = true
    number = true
    special = false  
}

resource "aws_db_subnet_group" "this" {
    name = "${var.project}-${var.stage}-${var.name}"
    subnet_ids = ["${var.subnet_1}", "${var.subnet_2}", "${var.subnet_3}"]

    tags = {
        Name = "${var.project}-${var.stage}-${var.name}"
    }
}

resource "aws_security_group" "this" {
    name = "${var.project}-${var.stage}-${var.name}-sg"
    description = "Allow connection to redshift from everywhere"
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        cidr_blocks = ["${var.access_ip}"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.project}-${var.stage}-${var.name}-sg"
    }
}

resource "aws_db_instance" "this" {
    identifier = "${var.project}-${var.stage}-${var.name}"
    
    name = "${var.database_name}" # database name 
    instance_class = "${var.instance_type}"
    allocated_storage = "${var.storage_gb}"
    engine = "postgres"
    engine_version = "${var.postgres_version}"
    skip_final_snapshot = true
    publicly_accessible = true
    db_subnet_group_name = "${aws_db_subnet_group.this.id}"
    vpc_security_group_ids = ["${aws_security_group.this.id}"]
    username = "root"
    password = "${random_string.password.result}"

    tags = {
        Name = "${var.project}-${var.stage}-${var.name}"
    }
}
