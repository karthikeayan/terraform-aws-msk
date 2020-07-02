resource "aws_cloudwatch_log_group" "msk_logs" {
  for_each    = var.enabled ? toset(["msk"]) : toset([])
  name        = "accel-msk-broker-logs"
}
