resource "aws_kinesis_firehose_delivery_stream" "affiliate_firehose" {
  name        = var.firehose_name
  destination = "extended_s3"
  #Note: s3_configuration is deprecated, use extended_s3_configuration instead. See here: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream#destination
  extended_s3_configuration {
    role_arn            = aws_iam_role.firehose_role.arn
    bucket_arn          = aws_s3_bucket.firehose_target.arn
    buffering_size      = var.firehose_buffering_size
    buffering_interval  = var.firehose_buffering_interval
    compression_format  = var.firehose_compression_format
    error_output_prefix = var.firehose_error_output_prefix
    prefix              = var.firehose_prefix
  }
  tags = { for tag_key, tag_value in local.merged_tags : tag_key => tag_value }
}
