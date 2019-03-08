module "base_network" {
  source = "./modules/network"

  project = "${var.project}"
  stage = "${var.stage}"

  vpc_cidr_block = "10.0.0.0/16"
  availability_zones = "${var.availability_zones}"
}

module "postgres_example" {
  source = "./modules/postgres_public_instance"

  project = "${var.project}"
  stage = "${var.stage}"
  name = "example"

  # network
  vpc_id = "${module.base_network.vpc_id}"
  subnet_1 = "${module.base_network.public_subnet_1}"
  subnet_2 = "${module.base_network.public_subnet_2}"
  subnet_3 = "${module.base_network.public_subnet_3}"

  access_ip = "0.0.0.0/0"
  
  # database configuration
  database_name = "main"
  instance_type = "db.t3.micro"
  storage_gb = "25"
  postgres_version = "10.6"
}

# TODO finish the module first
# module "lambda_example" {
#   source = "./lambda"

#   project_name = "${var.project_name}"
#   stage = "${var.stage}"
# }