resource "aws_cloudwatch_metric_alarm" "failed_pod_scheduling" {
  alarm_name          = "${var.cluster_name}-FailedPodScheduling"
  alarm_description   = "Triggered when pods cannot be scheduled in the Jira Clone EKS cluster"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "scheduler_schedule_attempts_UNSCHEDULABLE"
  namespace           = "AWS/EKS"
  period              = 60
  statistic           = "Average"
  threshold           = 0

  dimensions = {
    ClusterName = var.cluster_name
  }

  treat_missing_data = "missing"
  datapoints_to_alarm = 1

  alarm_actions = [aws_sns_topic.alerts.arn]

  tags = {
    Name        = "JiraCloneFailedPodScheduling"
  }
}

resource "aws_sns_topic" "alerts" {
  name = "jira-clone-alerts"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "le744rgqf@mozmail.com"
}
