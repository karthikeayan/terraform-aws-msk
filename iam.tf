resource "aws_iam_role" "msk_firehose_role" {
  for_each    = var.enabled ? toset(["msk"]) : toset([])
  name        = "accel-msk-firehose-role"

  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
  {
    "Action": "sts:AssumeRole",
    "Principal": {
      "Service": "firehose.amazonaws.com"
    },
    "Effect": "Allow",
    "Sid": ""
  }
  ]
}
EOF
}
