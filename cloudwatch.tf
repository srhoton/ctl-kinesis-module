resource "aws_cloudwatch_dashboard" "firehose_dashboard" {
  dashboard_name = var.dashboard_name
  dashboard_body = <<EOF
{
    "widgets": [
        {
            "type": "metric",
            "x": 0,
            "y": 0,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/Firehose", "DescribeDeliveryStream.Latency", "DeliveryStreamName", "exampleFirehose" ],
                    [ ".", "DescribeDeliveryStream.Requests", ".", "." ]
                ],
                "region": "us-east-1",
                "title": "Latency and Requests"
            }
        },
        {
            "type": "metric",
            "x": 6,
            "y": 0,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/S3", "NumberOfObjects", "BucketName", "srhoton-cur-bucket", "StorageType", "AllStorageTypes", { "period": 86400 } ],
                    [ ".", "BucketSizeBytes", ".", ".", ".", "StandardStorage", { "period": 86400 } ]
                ],
                "region": "us-east-1"
            }
        }
    ]
}
EOF
}

resource "aws_cloudwatch_metric_alarm" "firehose_incoming_records_alarm" {
  alarm_name          = var.incoming_records_alarm_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "IncomingRecords"
  namespace           = "AWS/Firehose"
  period              = var.incoming_records_alarm_period
  statistic         = "Average"
  threshold         = var.incoming_records_alarm_threshold
  alarm_description = "Alarm when the number of incoming records is too high for the Kinesis Firehose delivery stream ${aws_kinesis_firehose_delivery_stream.affiliate_firehose.name}"
  dimensions = {
    StreamName = aws_kinesis_firehose_delivery_stream.affiliate_firehose.name
  }
  alarm_actions = var.alarm_actions
}
