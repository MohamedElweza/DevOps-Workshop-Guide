
resource "aws_sqs_queue" "app_queue" {
  name                      = "app-queue"
  delay_seconds             = 5
  max_message_size          = 262144
  message_retention_seconds = 86400
  visibility_timeout_seconds = 30
  receive_wait_time_seconds = 10

  tags = {
    Name = "App-Queue"
  }
}
