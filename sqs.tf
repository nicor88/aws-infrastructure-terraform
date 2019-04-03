resource "aws_sqs_queue" "example_queue" {
  name                          = "example-queue"
  visibility_timeout_seconds    = 30
  delay_seconds                 = 0 # integer between 0 and 900 seconds, 15 minutes
  max_message_size              = 262144 # 256 KiB
  message_retention_seconds     = 1209600 # 14 days
  receive_wait_time_seconds     = 0 # time that the consumer needs to wait before start to process the object in the queue

  tags = {
    Environment = "${var.stage}"
  }
}
