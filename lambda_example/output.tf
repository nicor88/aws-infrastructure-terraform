output "lambda_example_arn" {
  value = "${aws_lambda_function.lambda_example.qualified_arn}"
}
