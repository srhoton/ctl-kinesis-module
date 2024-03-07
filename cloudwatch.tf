resource "aws_cloudwatch_dashboard" "firehose_dashboard" {
  dashboard_name = var.dashboard_name
  dashboard_body = <<EOF
{
    "Widgets": [
        {
            "Type": "Metric",
            "Properties": {
                "MetricDataQuery": {
                    "MetricStat": {
                        "Metrics": [
                            [
                                "AWS/KinesisDataStream",
                                "DescribeStreamStatistics",
                                null,
                                [
                                    {
                                        "Name": "${aws_kinesis_firehose_delivery_stream.affiliate_firehose.name}",
                                        "Value": ""
                                    }
                                ]
                            ],
                            {
                                "Label": "Throughput",
                                "MetricName": "IncomingBytesPerSecond"
                            },
                            {
                                "Label": "Records per second",
                                "MetricName": "RecordsPerSecond"
                            }
                        ]
                    },
                    "FilterPattern": "",
                    "Period": 60,
                    "Statistic": [
                        "SampleCount",
                        "Sum"
                    ]
                },
                "Title": "Kinesis Data Stream Metrics",
                "Height": {
                    "Type": "Percent",
                    "Value": 50
                },
                "Width": {
                    "Type": "Percent",
                    "Value": 50
                },
                "Y": 0,
                "X": 0
            }
        },
        {
            "Type": "Log",
            "Properties": {
                "Title": "Firehose Kinesis Data Stream Log",
                "FilterPattern": "",
                "StreamName": "${aws_kinesis_firehose_delivery_stream.affiliate_firehose.name}",
                "StartTime": "$$-NOW-30M",
                "EndTime": "$$-NOW",
                "Height": {
                    "Type": "Percent",
                    "Value": 50
                },
                "Width": {
                    "Type": "Percent",
                    "Value": 50
                },
                "Y": 50,
                "X": 0
            }
        }
    ],
    "Width": {
        "Type": "Pixels",
        "Value": 800
    },
    "Height": {
        "Type": "Pixels",
        "Value": 400
    }
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
