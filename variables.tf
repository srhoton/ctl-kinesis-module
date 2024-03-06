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
    condition     = var.retention_period >= 24 && var.retention_period <= 8760
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

variable "target_bucket_name" {
  description = "The name of the S3 bucket to use as the target for the Kinesis Firehose delivery stream"
  type        = string
  default     = "firehose-target-bucket"
}

variable "firehose_role_name" {
  description = "The name of the IAM role to create for the Kinesis Firehose delivery stream"
  type        = string
  default     = "firehose_delivery_role"
}

variable "firehose_policy_name" {
  description = "The name of the IAM policy to create for the Kinesis Firehose delivery stream"
  type        = string
  default     = "firehose_to_s3_policy"
}

variable "firehose_name" {
  description = "The name of the Kinesis Firehose delivery stream"
  type        = string
  default     = "exampleFirehose"
}

variable "firehose_buffer_size" {
  description = "The size of the buffer for the Kinesis Firehose delivery stream"
  type        = number
  default     = 10
  validation {
    condition     = var.firehose_buffer_size >= 1 && var.firehose_buffer_size <= 128
    error_message = "Buffer size must be greater than 1 but less than 128 MB"
  }
}

variable "firehose_buffer_interval" {
  description = "The interval for buffering data for the Kinesis Firehose delivery stream"
  type        = number
  default     = 400
  validation {
    condition     = var.firehose_buffer_interval >= 60 && var.firehose_buffer_interval <= 900
    error_message = "Buffer interval must be greater than 60 but less than 900 seconds"
  }
}

variable "firehose_compression_format" {
  description = "The compression format for the Kinesis Firehose delivery stream"
  type        = string
  default     = "GZIP"
  validation {
    condition     = var.firehose_compression_format == "GZIP" || var.firehose_compression_format == "UNCOMPRESSED" || var.firehose_compression_format == "snappy" || var.firehose_compression_format == "ZIP" || var.firehose_compression_format == "HADOOP_SNAPPY"
    error_message = "Compression format must be one of GZIP, UNCOMPRESSED, snappy, ZIP, or HADOOP_SNAPPY"
  }
}

variable "firehose_error_output_prefix" {
  description = "The prefix for the error output for the Kinesis Firehose delivery stream"
  type        = string
  default     = "firehose-errors/"
}

variable "firehose_prefix" {
  description = "The prefix for the data for the Kinesis Firehose delivery stream"
  type        = string
  default     = "firehose-data/"
}
