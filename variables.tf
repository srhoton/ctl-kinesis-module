variable "stream_name" {
  description = "The name of the Kinesis stream"
  type        = string
  default     = "affiliate_stream"
}

variable "shard_count" {
  description = "The number of shards for the Kinesis stream"
  type        = number
  default     = 1
}

variable "retention_period" {
  description = "The number of hours to retain data in the stream"
  type        = number
  default     = 24

  validation {
    condition     = var.retention_period > 24 && var.retention_period <= 8760
    error_message = "Retention period must be greater than 24 but less than 8760 hours"
  }
}

variable "tags_map" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default = {
    Module = "ctl-kinesis"
  }
}

variable "environment" {
  description = "The environment in which the resources are being created"
  type        = string
  default     = "Dev"
}

variable "shard_level_metrics" {
  description = "A list of shard-level CloudWatch metrics to enable"
  type        = list(string)
  default     = ["IncomingBytes", "OutgoingBytes"]
}
