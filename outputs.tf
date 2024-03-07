output "s3_bucket_id" {
  value       = aws_s3_bucket.firehose_target.id
  description = "The ID of the S3 bucket"
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.firehose_target.bucket
  description = "The name of the S3 bucket"
  
}
output "s3_bucket_arn" {
  value       = aws_s3_bucket.firehose_target.arn
  description = "The ARN of the S3 bucket"
}

output "firehose_id" {
  value       = aws_kinesis_firehose_delivery_stream.affiliate_firehose.id
  description = "The ID of the Kinesis Firehose"
}

output "firehose_arn" {
  value       = aws_kinesis_firehose_delivery_stream.affiliate_firehose.arn
  description = "The ARN of the Kinesis Firehose"
}

output "firehose_role_arn" {
  value       = aws_iam_role.firehose_role.arn
  description = "The ARN of the IAM role for the Kinesis Firehose"
}

output "cloudwatch_dashboard_url" {
  value       = aws_cloudwatch_dashboard.firehose_dashboard.id
  description = "The Id of the CloudWatch dashboard for the Kinesis Firehose"
}
