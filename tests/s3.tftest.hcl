run "bucket_named_correctly" {
  command = apply
  assert {
    condition     = module.ctl_kinesis.s3_bucket_name != null
    error_message = "S3 bucket name did not match expected"
  }
}

run "bucket_id_populated" {
  command = apply
  assert {
    condition     = module.ctl_kinesis.s3_bucket_id != null
    error_message = "S3 bucket id was not populated"
  }
}

run "bucket_arn_populated" {
  command = apply
  assert {
    condition     = module.ctl_kinesis.s3_bucket_arn != null
    error_message = "S3 bucket arn was not populated"
  }
}
