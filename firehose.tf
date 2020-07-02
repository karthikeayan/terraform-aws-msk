resource "aws_kinesis_firehose_delivery_stream" "msk_stream" {
  for_each    = var.enabled ? toset(["msk"]) : toset([])

  name        = "accel-kinesis-firehose-msk-broker-logs-stream"
  destination = "s3"

  s3_configuration {
    role_arn   = aws_iam_role.msk_firehose_role["msk"].arn
    bucket_arn = aws_s3_bucket.msk_bucket["msk"].arn
  }

  tags = {
    LogDeliveryEnabled = "true"
  }

  lifecycle {
    ignore_changes = [
      tags["LogDeliveryEnabled"],
    ]
  }
}
