# CIS CloudWatch Controls Terraform Module

This module will create Amazon CloudWatch controls for the CIS AWS Foundations Benchmark versions v1.2.0 or v1.4.0.

The controls are described in more detail in the [AWS Documentation](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html)

## Usage

        module "cis_controls" {
          source = "cweiblen/cis_cloudwatch_controls"

          cloudwatch_log_group = "cloudtrail"
          cis_benchmark_version = "1.4.0"
        }

To override the rules enabled, pass a list of rules IDs in the `enabled_rules` variable

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.40 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.40 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_metric_filter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_metric_alarm.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cis_benchmark_version"></a> [cis\_benchmark\_version](#input\_cis\_benchmark\_version) | Version of CIS benchmark, valid values are '1.2.0' or '1.4.0' | `string` | `"1.4.0"` | no |
| <a name="input_cloudwatch_log_group"></a> [cloudwatch\_log\_group](#input\_cloudwatch\_log\_group) | CloudTrail CloudWatch log group name | `string` | n/a | yes |
| <a name="input_create_sns_topic"></a> [create\_sns\_topic](#input\_create\_sns\_topic) | Create SNS topic for CloudWatch Alarm notifications | `bool` | `true` | no |
| <a name="input_enabled_rules"></a> [enabled\_rules](#input\_enabled\_rules) | Override list of rule IDs to enable | `list(string)` | `[]` | no |
| <a name="input_sns_topic_arn"></a> [sns\_topic\_arn](#input\_sns\_topic\_arn) | SNS Topic ARN for CloudWatch Alarm notifications.  Required if `create_sns_topic` is false | `string` | `""` | no |
| <a name="input_sns_topic_name"></a> [sns\_topic\_name](#input\_sns\_topic\_name) | Name for SNS topic | `string` | `"cloudwatch-log-metric-alarms"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
