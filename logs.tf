resource "aws_cloudwatch_log_group" "gatus_log_group" {
  name              = "gatus_log_group"
  retention_in_days = 30

  tags = {
    name = "gatus-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "gatus_log_stream" {
  name           = "gatus_log_stream"
  log_group_name = aws_cloudwatch_log_group.gatus_log_group.name
} 