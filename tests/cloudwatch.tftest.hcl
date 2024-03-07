run "cloudwatch_dashboard_id_populated" {
  command = apply
  assert {
    condition     = module.ctl_kinesis.cloudwatch_dashboard_id != null
    error_message = "cloudwatch_dashboard_id was not populated"
  }
}
