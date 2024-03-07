resource "aws_s3_bucket" "firehose_target" {
  bucket = var.target_bucket_name
  #This is deprecated (see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#acl), use the acl block instead
  #acl = "private"
  tags = { for tag_key, tag_value in local.merged_tags : tag_key => tag_value }

}

resource "aws_s3_bucket_ownership_controls" "firehose_target" {
  bucket = aws_s3_bucket.firehose_target.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "firehose_target" {
  bucket     = aws_s3_bucket.firehose_target.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.firehose_target]
}
