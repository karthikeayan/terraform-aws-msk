resource "aws_security_group" "security_group" {
  for_each    = var.enabled ? toset(["msk"]) : toset([])
  name        = "accel-msk-sg-${var.env}"
  vpc_id      = var.vpc_id
}
