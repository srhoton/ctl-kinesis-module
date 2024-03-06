resource "aws_kinesis_firehose_delivery_stream" "affiliate_firehose" {
  name        = var.firehose_name
  destination = "s3"
  s3_configuration {
    role_arn            = aws_iam_role.firehose_role.arn
    bucket_arn          = aws_s3_bucket.firehose_target.arn
    buffer_size         = var.firehose_buffer_size
    buffer_interval     = var.firehose_buffer_interval
    compression_format  = var.firehose_compression_format
    error_output_prefix = var.firehose_error_output_prefix
    prefix              = var.firehose_prefix
  }
  tags = { for tag_key, tag_value in local.merged_tags : tag_key => tag_value }
}
