# ctl-kinesis-module
POC for module that builds infrastructure to support Kinesis->Data Firehouse-S3
## Overview
This module creates the need a different structure to create a Kinesis Stream, which is used as an input to AWS Data Firehose, which then writes to an S3 bucket.  The module also creates a CloudWatch dashboard to monitor the Kinesis Stream and Data Firehose.

## Example Usage

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_dashboard.firehose_dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_dashboard) | resource |
| [aws_cloudwatch_metric_alarm.firehose_delivery_to_s3_bytes_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.firehose_incoming_records_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_iam_policy.firehose_to_s3_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.firehose_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.firehose_to_s3_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kinesis_firehose_delivery_stream.affiliate_firehose](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream) | resource |
| [aws_kinesis_stream.affiliate_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_stream) | resource |
| [aws_s3_bucket.firehose_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.firehose_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_ownership_controls.firehose_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_actions"></a> [alarm\_actions](#input\_alarm\_actions) | A list of ARNs to use as alarm actions | `list(string)` | `[]` | no |
| <a name="input_dashboard_name"></a> [dashboard\_name](#input\_dashboard\_name) | The name of the CloudWatch dashboard | `string` | `"FirehoseMonitoring"` | no |
| <a name="input_delivery_to_s3_bytes_alarm_evaluation_periods"></a> [delivery\_to\_s3\_bytes\_alarm\_evaluation\_periods](#input\_delivery\_to\_s3\_bytes\_alarm\_evaluation\_periods) | The number of periods for the CloudWatch alarm for delivery to S3 bytes | `number` | `1` | no |
| <a name="input_delivery_to_s3_bytes_alarm_name"></a> [delivery\_to\_s3\_bytes\_alarm\_name](#input\_delivery\_to\_s3\_bytes\_alarm\_name) | The name of the CloudWatch alarm for delivery to S3 bytes | `string` | `"high-delivery-to-s3-bytes"` | no |
| <a name="input_delivery_to_s3_bytes_alarm_period"></a> [delivery\_to\_s3\_bytes\_alarm\_period](#input\_delivery\_to\_s3\_bytes\_alarm\_period) | The period for the CloudWatch alarm for delivery to S3 bytes | `number` | `300` | no |
| <a name="input_delivery_to_s3_bytes_alarm_threshold"></a> [delivery\_to\_s3\_bytes\_alarm\_threshold](#input\_delivery\_to\_s3\_bytes\_alarm\_threshold) | The threshold for the CloudWatch alarm for delivery to S3 bytes | `number` | `1000000` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the resources are being created | `string` | `"Dev"` | no |
| <a name="input_firehose_buffering_interval"></a> [firehose\_buffering\_interval](#input\_firehose\_buffering\_interval) | The interval for buffering data for the Kinesis Firehose delivery stream | `number` | `400` | no |
| <a name="input_firehose_buffering_size"></a> [firehose\_buffering\_size](#input\_firehose\_buffering\_size) | The size of the buffer for the Kinesis Firehose delivery stream | `number` | `10` | no |
| <a name="input_firehose_compression_format"></a> [firehose\_compression\_format](#input\_firehose\_compression\_format) | The compression format for the Kinesis Firehose delivery stream | `string` | `"GZIP"` | no |
| <a name="input_firehose_error_output_prefix"></a> [firehose\_error\_output\_prefix](#input\_firehose\_error\_output\_prefix) | The prefix for the error output for the Kinesis Firehose delivery stream | `string` | `"firehose-errors/"` | no |
| <a name="input_firehose_name"></a> [firehose\_name](#input\_firehose\_name) | The name of the Kinesis Firehose delivery stream | `string` | `"exampleFirehose"` | no |
| <a name="input_firehose_policy_name"></a> [firehose\_policy\_name](#input\_firehose\_policy\_name) | The name of the IAM policy to create for the Kinesis Firehose delivery stream | `string` | `"firehose_to_s3_policy"` | no |
| <a name="input_firehose_prefix"></a> [firehose\_prefix](#input\_firehose\_prefix) | The prefix for the data for the Kinesis Firehose delivery stream | `string` | `"firehose-data/"` | no |
| <a name="input_firehose_role_name"></a> [firehose\_role\_name](#input\_firehose\_role\_name) | The name of the IAM role to create for the Kinesis Firehose delivery stream | `string` | `"firehose_delivery_role"` | no |
| <a name="input_incoming_records_alarm_evaluation_periods"></a> [incoming\_records\_alarm\_evaluation\_periods](#input\_incoming\_records\_alarm\_evaluation\_periods) | The number of periods for the CloudWatch alarm for incoming records | `number` | `1` | no |
| <a name="input_incoming_records_alarm_name"></a> [incoming\_records\_alarm\_name](#input\_incoming\_records\_alarm\_name) | The name of the CloudWatch alarm for incoming records | `string` | `"high-incoming-records"` | no |
| <a name="input_incoming_records_alarm_period"></a> [incoming\_records\_alarm\_period](#input\_incoming\_records\_alarm\_period) | The period for the CloudWatch alarm for incoming records | `number` | `300` | no |
| <a name="input_incoming_records_alarm_threshold"></a> [incoming\_records\_alarm\_threshold](#input\_incoming\_records\_alarm\_threshold) | The threshold for the CloudWatch alarm for incoming records | `number` | `1000` | no |
| <a name="input_retention_period"></a> [retention\_period](#input\_retention\_period) | The number of hours to retain data in the stream | `number` | `24` | no |
| <a name="input_shard_count"></a> [shard\_count](#input\_shard\_count) | The number of shards for the Kinesis stream | `number` | `1` | no |
| <a name="input_shard_level_metrics"></a> [shard\_level\_metrics](#input\_shard\_level\_metrics) | A list of shard-level CloudWatch metrics to enable | `list(string)` | <pre>[<br>  "IncomingBytes",<br>  "OutgoingBytes"<br>]</pre> | no |
| <a name="input_stream_name"></a> [stream\_name](#input\_stream\_name) | The name of the Kinesis stream | `string` | `"affiliate_stream"` | no |
| <a name="input_tags_map"></a> [tags\_map](#input\_tags\_map) | A map of tags to assign to the resource | `map(string)` | <pre>{<br>  "Module": "ctl-kinesis"<br>}</pre> | no |
| <a name="input_target_bucket_name_prefix"></a> [target\_bucket\_name\_prefix](#input\_target\_bucket\_name\_prefix) | The prefix of the S3 bucket to use as the target for the Kinesis Firehose delivery stream | `string` | `"firehose-target-bucket"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_dashboard_id"></a> [cloudwatch\_dashboard\_id](#output\_cloudwatch\_dashboard\_id) | The Id of the CloudWatch dashboard for the Kinesis Firehose |
| <a name="output_firehose_arn"></a> [firehose\_arn](#output\_firehose\_arn) | The ARN of the Kinesis Firehose |
| <a name="output_firehose_id"></a> [firehose\_id](#output\_firehose\_id) | The ID of the Kinesis Firehose |
| <a name="output_firehose_role_arn"></a> [firehose\_role\_arn](#output\_firehose\_role\_arn) | The ARN of the IAM role for the Kinesis Firehose |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The ARN of the S3 bucket |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | The ID of the S3 bucket |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | The name of the S3 bucket |
