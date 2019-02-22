variable "project_name" {}
variable "stage" {}

variable "subnet1" {}
variable "subnet2" {}

variable "postgres_public_sg" {}

resource "random_string" "password" {
    length = 32
    upper = true
    number = true
    special = false  
}

resource "aws_db_subnet_group" "subnet_group" {
    name = "${var.project_name}-${var.stage}"
    subnet_ids = ["${var.subnet1}", "${var.subnet2}"]

    tags = {
        Name = "${var.project_name}-${var.stage}-subnet-group"
    }
}

resource "aws_db_instance" "instance" {
    identifier = "${var.project_name}-${var.stage}-postgres"
    
    # database name 
    name = "playground"
    instance_class = "db.t3.micro"
    allocated_storage = 30
    engine = "postgres"
    engine_version = "10.6"
    skip_final_snapshot = true
    publicly_accessible = true
    db_subnet_group_name = "${aws_db_subnet_group.subnet_group.id}"
    vpc_security_group_ids = ["${var.postgres_public_sg}"]
    username = "root"
    password = "${random_string.password.result}"

    tags = {
        Name = "${var.project_name}-${var.stage}-postgres"
    }
}

# retrieve the password running: terraform output -module=postgres
