resource "aws_s3_bucket" "msk_bucket" {
  for_each    = var.enabled ? toset(["msk"]) : toset([])

  bucket      = "accel-msk-broker-${var.env}"
  acl         = "private"
}
