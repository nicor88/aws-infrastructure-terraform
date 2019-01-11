# modules
module "network" {
  source = "./network"

  project_name = "${var.project_name}"
  stage = "${var.stage}"

  base_cidr_block = "${var.base_cidr_block}"
  availability_zones = "${var.availability_zones}"
}


module "lambda_example" {
  source = "./lambda_example"

  project_name = "${var.project_name}"
  stage = "${var.stage}"

  vpc_id = "${module.network.vpc_id}"
}

module "ecs" {
  source = "./ecs"

  project_name = "${var.project_name}"
  stage = "${var.stage}"
}
