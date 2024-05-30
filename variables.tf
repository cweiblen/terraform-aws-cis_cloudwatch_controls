
variable "enabled_rules" {
  description = "List of rule IDs to enable"
  type = list(string)
  default = ["1","4","5","6","7","8","9","10","11","12","13","14"]
}

variable "create_sns_topic" {
  description = "Create SNS topic for CloudWatch Alarm notifications"
  type = bool
  default = true
}

variable "sns_topic_name" {
  description = "Name for SNS topic"
  type = string
  default = "cloudwatch-log-metric-alarms"
}

variable "sns_topic_arn" {
  description = "SNS Topic ARN for CloudWatch Alarm notifications.  Required if `create_sns_topic` is false"
  type = string
  default = ""
}

variable "cloudwatch_log_group" {
  description = "CloudTrail CloudWatch log group name"
  type = string
  nullable = false
}
