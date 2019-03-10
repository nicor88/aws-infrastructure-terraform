resource "aws_dynamodb_table" "this" {
    name           = "${var.stage}-${var.table_name}"
    billing_mode   = "PROVISIONED" # default
    read_capacity  = "${var.read_capacity}"
    write_capacity = "${var.write_capacity}"
    hash_key       = "${var.primary_key}"
    range_key = "${var.sort_key == "" ? "" : var.sort_key }"

    attribute = [
        {
            name = "${var.primary_key}"
            type = "${var.primary_key_type}"
        },
        "${var.attributes}",
    ]

    point_in_time_recovery {
        enabled = "${var.enable_recovery}"
    }

    # to use if autoscaling policies are enabled
    lifecycle {
        ignore_changes = [
            "read_capacity",
            "write_capacity",
        ]
    }

    tags = {
        Name        = "${var.stage}-${var.table_name}"
        Environment = "${var.stage}"
    }
}

resource "aws_appautoscaling_target" "dynamodb_table_read_target" {
  min_capacity       = "${var.read_capacity}"
  max_capacity       = "${var.read_max_capacity}"
  resource_id        = "table/${aws_dynamodb_table.this.name}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
  role_arn = "arn:aws:iam::${var.aws_account_id}:role/aws-service-role/dynamodb.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_DynamoDBTable"

}

resource "aws_appautoscaling_policy" "dynamodb_table_read_policy" {
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_read_target.resource_id}"
  policy_type        = "TargetTrackingScaling"

  # this options are really configurable
  resource_id        = "${aws_appautoscaling_target.dynamodb_table_read_target.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.dynamodb_table_read_target.scalable_dimension}"
  service_namespace  = "${aws_appautoscaling_target.dynamodb_table_read_target.service_namespace}"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    scale_in_cooldown  = "${var.read_scale_in_cooldown}"
    scale_out_cooldown = "${var.read_scale_out_cooldown}"

    target_value = "${var.read_percentage_scaling}"
  }
}

resource "aws_appautoscaling_target" "dynamodb_table_write_target" {
  min_capacity       = "${var.write_capacity}"
  max_capacity       = "${var.write_max_capacity}"
  resource_id        = "table/${aws_dynamodb_table.this.name}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
  role_arn = "arn:aws:iam::${var.aws_account_id}:role/aws-service-role/dynamodb.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_DynamoDBTable"
}

resource "aws_appautoscaling_policy" "dynamodb_table_write_policy" {
  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_write_target.resource_id}"
  policy_type        = "TargetTrackingScaling"

  # this options are really configurable
  resource_id        = "${aws_appautoscaling_target.dynamodb_table_write_target.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.dynamodb_table_write_target.scalable_dimension}"
  service_namespace  = "${aws_appautoscaling_target.dynamodb_table_write_target.service_namespace}"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    scale_in_cooldown  = "${var.write_scale_in_cooldown}"
    scale_out_cooldown = "${var.write_scale_out_cooldown}"

    target_value = "${var.write_percentage_scaling}"
  }
}
