run "firehose_id_populated" {
  command = apply
  assert {
    condition     = module.ctl_kinesis.firehose_id != null
    error_message = "firehose id was not populated"
  }
}

run "firehose_arn_populated" {
  command = apply
  assert {
    condition     = module.ctl_kinesis.firehose_arn != null
    error_message = "firehose arn was not populated"
  }
}

run "firehose_role_arn_populated" {
  command = apply
  assert {
    condition     = module.ctl_kinesis.firehose_role_arn != null
    error_message = "firehose role arn was not populated"
  }
}
