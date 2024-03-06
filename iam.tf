resource "aws_iam_role" "firehose_role" {
  name = var.firehose_role_name
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "firehose.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  tags = { for tag_key, tag_value in local.merged_tags : tag_key => tag_value }
}

resource "aws_iam_policy" "firehose_to_s3_policy" {
  name = var.firehose_policy_name
  policy = jsonencode({
    Statement = [{
      Action = [
        "s3:AbortMultipartUpload",
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:PutObject"
      ]
      Effect = "Allow"
      Resource = [
        "${aws_s3_bucket.firehose_target.arn}",
        "${aws_s3_bucket.firehose_target.arn}/*"
      ]
    }]
    Version = "2012-10-17"
  })
  tags = { for tag_key, tag_value in local.merged_tags : tag_key => tag_value }
}

resource "aws_iam_role_policy_attachment" "firehose_to_s3_attach" {
  role       = aws_iam_role.firehose_role.name
  policy_arn = aws_iam_policy.firehose_to_s3_policy.arn
}
