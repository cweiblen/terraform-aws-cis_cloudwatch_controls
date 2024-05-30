
variable "create_sns_topic" {
  description = "Create SNS topic for CloudWatch Alarm notifications"
  type        = bool
  default     = true
}

variable "sns_topic_name" {
  description = "Name for SNS topic"
  type        = string
  default     = "cloudwatch-log-metric-alarms"
}

variable "sns_topic_arn" {
  description = "SNS Topic ARN for CloudWatch Alarm notifications.  Required if `create_sns_topic` is false"
  type        = string
  default     = ""
}

variable "cloudwatch_log_group" {
  description = "CloudTrail CloudWatch log group name"
  type        = string
  nullable    = false
}

variable "cis_benchmark_version" {
  description = "Version of CIS benchmark, valid values are '1.2.0' or '1.4.0'"
  type        = string
  default     = "1.4.0"
  validation {
    condition     = contains(["1.2.0", "1.4.0"], var.cis_benchmark_version)
    error_message = "cis_benchmark_version must be one of either '1.2.0' or '1.4.0'"
  }
}

variable "enabled_rules" {
  description = "Override list of rule IDs to enable"
  type        = list(string)
  default     = []
}
