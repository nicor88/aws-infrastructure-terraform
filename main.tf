module "base_network" {
  source = "./modules/network"

  project = "${var.project}"
  stage = "${var.stage}"

  vpc_cidr_block = "10.0.0.0/16"
  availability_zones = "${var.availability_zones}"
}

# module "postgres_example" {
#   source = "./modules/postgres_public_instance"

#   project = "${var.project}"
#   stage = "${var.stage}"
#   name = "example"

#   # network
#   vpc_id = "${module.base_network.vpc_id}"
#   subnet_1 = "${module.base_network.public_subnet_1}"
#   subnet_2 = "${module.base_network.public_subnet_2}"
#   subnet_3 = "${module.base_network.public_subnet_3}"

#   access_ip = "0.0.0.0/0"
  
#   # database configuration
#   database_name = "main"
#   instance_type = "db.t2.micro"
#   storage_gb = "10"
#   postgres_version = "10.6"
# }

module "lambda_example" {
  source = "./modules/lambda_no_vpc_source_code"

  stage = "${var.stage}"
  name = "example"
  description = "Just a sample lambda"
  source_file_path = "lambdas/example/lambda.py"
}

module "lambda_example_2" {
  source = "./modules/lambda_no_vpc_artifact"

  stage = "${var.stage}"
  name = "example-2"
  description = "Just a sample lambda"
  source_artifact = ".packaged_lambda/example_2.zip"
}

# example how to extend lambda role policy
resource "aws_iam_policy" "s3" {
  name        = "${var.stage}-example-2-s3"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_policy_to_example_2_role" {
  role       = "${module.lambda_example_2.lambda_role_name}"
  policy_arn = "${aws_iam_policy.s3.arn}"
}
