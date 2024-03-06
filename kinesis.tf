resource "aws_kinesis_stream" "affiliate_stream" {
  name             = var.stream_name
  shard_count      = var.shard_count
  shard_level_metrics = var.shard_level_metrics
  retention_period = 24
  tags = { for tag_key, tag_value in local.merged_tags : tag_key => tag_value}
}
