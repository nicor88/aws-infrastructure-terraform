
data "archive_file" "zip" {
  type = "zip"
  source_file = "${var.source_file_path}"
  output_path = ".packaged_lambda/${var.project}_${var.stage}_${var.name}.zip"
}

resource "aws_iam_role" "this" {
  name = "${var.project}-${var.stage}-${var.name}-lambda"

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

resource "aws_iam_policy" "logs" {
  name        = "${var.project}-${var.stage}-${var.name}-logs"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = "${aws_iam_role.this.name}"
  policy_arn = "${aws_iam_policy.logs.arn}"
}

resource "aws_lambda_function" "this" {
  function_name = "${var.project}-${var.stage}-${var.name}"
  description = "${var.description}"
  handler = "lambda.lambda_handler"
  runtime = "python3.6"
  timeout = 300

  filename         = "${data.archive_file.zip.output_path}"
  source_code_hash = "${data.archive_file.zip.output_base64sha256}"

  role = "${aws_iam_role.this.arn}"

  environment {
    variables = {
      STAGE = "${var.stage}"
    }
  }
}
