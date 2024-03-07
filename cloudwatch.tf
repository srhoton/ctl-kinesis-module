resource "aws_cloudwatch_dashboard" "firehose_dashboard" {
  dashboard_name = var.dashboard_name
  dashboard_body = <<EOF
{
    "Widgets": [
        {
            "Type": "Metric",
            "X": 0,
            "Y": 0,
            "Width": 12,
            "Height": 6,
            "Properties": {
                "Metrics": [
                    [
                        "AWS/Firehose",
                        "IncomingRecords",
                        "DeliveryStreamName",
                        "${aws_kinesis_firehose_delivery_stream.affiliate_firehose.name}"
                    ],
                    [
                        ".",
                        "DeliveryToS3.Bytes",
                        ".",
                        "."
                    ]
                ],
                "View": "timeSeries",
                "Stacked": "false"
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
