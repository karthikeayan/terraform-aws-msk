resource "aws_kms_key" "msk_kms" {
  for_each    = var.enabled ? toset(["msk"]) : toset([])
  description = "accel-msk-key"
}
