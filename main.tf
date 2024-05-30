locals {
  sns_topic_arn = var.create_sns_topic ? aws_sns_topic.this[0].arn : var.sns_topic_arn

  cloudwatch_log_metrics = {
    "1" = {
      description = "[A log metric filter and alarm should exist for usage of the \"root\" user](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-1)"
      pattern     = "{$.userIdentity.type=\"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType !=\"AwsServiceEvent\"}"
    },
    "2" = {
      description = "[Ensure a log metric filter and alarm exist for unauthorized API calls](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-2)"
      pattern     = "{($.errorCode=\"*UnauthorizedOperation\") || ($.errorCode=\"AccessDenied*\")}"
    },
    "3" = {
      description = "[Ensure a log metric filter and alarm exist for Management Console sign-in without MFA](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-3)"
      pattern     = "{ ($.eventName = \"ConsoleLogin\") && ($.additionalEventData.MFAUsed != \"Yes\") && ($.userIdentity.type = \"IAMUser\") && ($.responseElements.ConsoleLogin = \"Success\") }"
    },
    "4" = {
      description = "[Ensure a log metric filter and alarm exist for IAM policy changes](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-4)"
      pattern     = "{($.eventSource=iam.amazonaws.com) && (($.eventName=DeleteGroupPolicy) || ($.eventName=DeleteRolePolicy) || ($.eventName=DeleteUserPolicy) || ($.eventName=PutGroupPolicy) || ($.eventName=PutRolePolicy) || ($.eventName=PutUserPolicy) || ($.eventName=CreatePolicy) || ($.eventName=DeletePolicy) || ($.eventName=CreatePolicyVersion) || ($.eventName=DeletePolicyVersion) || ($.eventName=AttachRolePolicy) || ($.eventName=DetachRolePolicy) || ($.eventName=AttachUserPolicy) || ($.eventName=DetachUserPolicy) || ($.eventName=AttachGroupPolicy) || ($.eventName=DetachGroupPolicy))}"
    },
    "5" = {
      description = "[Ensure a log metric filter and alarm exist for CloudTrail AWS Configuration changes](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-5)"
      pattern     = "{($.eventName=CreateTrail) || ($.eventName=UpdateTrail) || ($.eventName=DeleteTrail) || ($.eventName=StartLogging) || ($.eventName=StopLogging)}"
    },
    "6" = {
      description = "[Ensure a log metric filter and alarm exist for AWS Management Console authentication failures](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-6)"
      pattern     = "{($.eventName=ConsoleLogin) && ($.errorMessage=\"Failed authentication\")}"
    },
    "7" = {
      description = "[Ensure a log metric filter and alarm exist for disabling or scheduled deletion of customer managed keys](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-7)"
      pattern     = "{($.eventSource=kms.amazonaws.com) && (($.eventName=DisableKey) || ($.eventName=ScheduleKeyDeletion))}"
    },
    "8" = {
      description = "[Ensure a log metric filter and alarm exist for S3 bucket policy changes](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-8)"
      pattern     = "{($.eventSource=s3.amazonaws.com) && (($.eventName=PutBucketAcl) || ($.eventName=PutBucketPolicy) || ($.eventName=PutBucketCors) || ($.eventName=PutBucketLifecycle) || ($.eventName=PutBucketReplication) || ($.eventName=DeleteBucketPolicy) || ($.eventName=DeleteBucketCors) || ($.eventName=DeleteBucketLifecycle) || ($.eventName=DeleteBucketReplication))}"
    },
    "9" = {
      description = "[Ensure a log metric filter and alarm exist for AWS Config configuration changes](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-9)"
      pattern     = "{($.eventSource=config.amazonaws.com) && (($.eventName=StopConfigurationRecorder) || ($.eventName=DeleteDeliveryChannel) || ($.eventName=PutDeliveryChannel) || ($.eventName=PutConfigurationRecorder))}"
    },
    "10" = {
      description = "[Ensure a log metric filter and alarm exist for security group changes](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-10)"
      pattern     = "{($.eventName=AuthorizeSecurityGroupIngress) || ($.eventName=AuthorizeSecurityGroupEgress) || ($.eventName=RevokeSecurityGroupIngress) || ($.eventName=RevokeSecurityGroupEgress) || ($.eventName=CreateSecurityGroup) || ($.eventName=DeleteSecurityGroup)}"
    },
    "11" = {
      id                = 11
      description       = "[Ensure a log metric filter and alarm exist for changes to Network Access Control Lists (NACL)](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-11)"
      pattern           = "{($.eventName=CreateNetworkAcl) || ($.eventName=CreateNetworkAclEntry) || ($.eventName=DeleteNetworkAcl) || ($.eventName=DeleteNetworkAclEntry) || ($.eventName=ReplaceNetworkAclEntry) || ($.eventName=ReplaceNetworkAclAssociation)}"
      alarm_description = "[Ensure a log metric filter and alarm exist for changes to Network Access Control Lists (NACL)](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-11)"
    },
    "12" = {
      description = "[Ensure a log metric filter and alarm exist for changes to network gateways](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-12)"
      pattern     = "{($.eventName=CreateCustomerGateway) || ($.eventName=DeleteCustomerGateway) || ($.eventName=AttachInternetGateway) || ($.eventName=CreateInternetGateway) || ($.eventName=DeleteInternetGateway) || ($.eventName=DetachInternetGateway)}"
    },
    "13" = {
      id                = 13
      description       = "[Ensure a log metric filter and alarm exist for route table changes](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-13)"
      pattern           = "{($.eventSource=ec2.amazonaws.com) && (($.eventName=CreateRoute) || ($.eventName=CreateRouteTable) || ($.eventName=ReplaceRoute) || ($.eventName=ReplaceRouteTableAssociation) || ($.eventName=DeleteRouteTable) || ($.eventName=DeleteRoute) || ($.eventName=DisassociateRouteTable))}"
      alarm_description = "[Ensure a log metric filter and alarm exist for route table changes](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-13)"
    },
    "14" = {
      description = "[Ensure a log metric filter and alarm exist for VPC changes](https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-14)"
      pattern     = "{($.eventName=CreateVpc) || ($.eventName=DeleteVpc) || ($.eventName=ModifyVpcAttribute) || ($.eventName=AcceptVpcPeeringConnection) || ($.eventName=CreateVpcPeeringConnection) || ($.eventName=DeleteVpcPeeringConnection) || ($.eventName=RejectVpcPeeringConnection) || ($.eventName=AttachClassicLinkVpc) || ($.eventName=DetachClassicLinkVpc) || ($.eventName=DisableVpcClassicLink) || ($.eventName=EnableVpcClassicLink)}"
    }
  }

  cis_benchmark_rules = {
    "1.2.0" = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"],
    "1.4.0" = ["1", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"]
  }

  enabled_rules = length(var.enabled_rules) > 0 ? var.enabled_rules : local.cis_benchmark_rules[var.cis_benchmark_version]
}

resource "aws_sns_topic" "this" {
  count = var.create_sns_topic ? 1 : 0
  name  = var.sns_topic_name
}

resource "aws_cloudwatch_log_metric_filter" "this" {
  for_each = toset(local.enabled_rules)

  name           = "CloudWatch.${each.key}"
  log_group_name = var.cloudwatch_log_group
  pattern        = local.cloudwatch_log_metrics[each.key].pattern

  metric_transformation {
    name          = "CloudWatch.${each.key}"
    namespace     = "LogMetrics"
    value         = 1
    default_value = 0
  }
}

resource "aws_cloudwatch_metric_alarm" "this" {
  for_each = toset(local.enabled_rules)

  alarm_name                = "CloudWatch.${each.key}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 1
  metric_name               = "CloudWatch.${each.key}"
  namespace                 = "LogMetrics"
  period                    = 300
  statistic                 = "Maximum"
  threshold                 = 1
  alarm_description         = local.cloudwatch_log_metrics[each.key].description
  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []
  datapoints_to_alarm       = 1
  alarm_actions             = [local.sns_topic_arn]
}
