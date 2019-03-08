variable "project_name" {}
variable "stage" {}

data "archive_file" "zip" {
  type = "zip"
  source_file = "lambda/source_code/lambda_example.py"
  output_path = ".packaged_lambda/lambda_example.zip"
}

resource "aws_iam_role" "lambda_iam_role" {
  name = "${var.project_name}-${var.stage}-lambda-example-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda_example" {
  function_name = "${var.project_name}-${var.stage}-example"
  description = "Example lambda to start to deploy resources with Terraform"
  handler = "lambda_example.lambda_handler"
  runtime = "python3.6"
  timeout = 300

  filename         = "${data.archive_file.zip.output_path}"
  source_code_hash = "${data.archive_file.zip.output_base64sha256}"

  role = "${aws_iam_role.lambda_iam_role.arn}"

  environment {
    variables = {
      STAGE = "${var.stage}"
    }
  }
}
