resource "aws_msk_cluster" "msk_cluster" {
  for_each    = var.enabled ? toset(["msk"]) : toset([])

  cluster_name           = "accel-msk-${var.env}"
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.node_count

  broker_node_group_info {
    instance_type   = var.instance_type
    ebs_volume_size = 50
    client_subnets = var.subnets
    security_groups = [aws_security_group.security_group["msk"].id]
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.msk_kms["msk"].arn
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }
      node_exporter {
        enabled_in_broker = true
      }
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.msk_logs["msk"].name
      }
      firehose {
        enabled         = true
        delivery_stream = aws_kinesis_firehose_delivery_stream.msk_stream["msk"].name
      }
      s3 {
        enabled = true
        bucket  = aws_s3_bucket.msk_bucket["msk"].id
        prefix  = "logs/msk-"
      }
    }
  }

  tags = var.tags
}
