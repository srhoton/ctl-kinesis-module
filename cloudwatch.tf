resource "aws_cloudwatch_dashboard" "firehose_dashboard" {
  dashboard_name = var.dashboard_name
  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/Firehose", "IncomingRecords", "DeliveryStreamName", aws_kinesis_firehose_delivery_stream.affiliate_firehose.name]
          ]
          view    = "timeSeries"
          stacked = false,
          title   = "Incoming Records",
          region  = "us-east-1",
          annotations = {
            horizontal = [
              {
                label = "Alarm Threshold"
                value = var.incoming_records_alarm_threshold
                color = "#ff0000"
              }
            ]
          },
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/S3", "DeliveryToS3.Bytes", "BucketName", aws_s3_bucket.firehose_target.id]
          ]
          view    = "timeSeries"
          stacked = false,
          title   = "Delivery to S3 Bytes",
          region  = "us-east-1",
          annotations = {
            horizontal = [
              {
                label = "Alarm Threshold"
                value = var.delivery_to_s3_bytes_alarm_threshold
                color = "#ff0000"
              }
            ]
          },
        }
      }
    ]
  })
}

resource "aws_cloudwatch_metric_alarm" "firehose_incoming_records_alarm" {
  alarm_name          = var.incoming_records_alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "IncomingRecords"
  namespace           = "AWS/Firehose"
  period              = var.incoming_records_alarm_period
  statistic           = "Average"
  threshold           = var.incoming_records_alarm_threshold
  alarm_description   = "Alarm when the number of incoming records is too high for the Kinesis Firehose delivery stream ${aws_kinesis_firehose_delivery_stream.affiliate_firehose.name}"
  dimensions = {
    StreamName = aws_kinesis_firehose_delivery_stream.affiliate_firehose.name
  }
  alarm_actions = var.alarm_actions
}

resource "aws_cloudwatch_metric_alarm" "firehose_delivery_to_s3_bytes_alarm" {
  alarm_name          = var.delivery_to_s3_bytes_alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "DeliveryToS3.Bytes"
  namespace           = "AWS/Firehose"
  period              = var.delivery_to_s3_bytes_alarm_period
  statistic           = "Average"
  threshold           = var.delivery_to_s3_bytes_alarm_threshold
  alarm_description   = "Alarm when the number of bytes delivered to S3 is too high for the Kinesis Firehose delivery stream ${aws_kinesis_firehose_delivery_stream.affiliate_firehose.name}"
  dimensions = {
    Name  = "BucketName"
    Value = aws_s3_bucket.firehose_target.id
  }
  alarm_actions = var.alarm_actions
}
