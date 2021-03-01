data "aws_caller_identity" "current" {}

variable "aws-account-id" {
  default = "my-aws-account-id"
}

variable "aws-region" {
  default = "ap-southeast-1"
}

variable "sns-topic-prefix" {
  default = "codecommit-"
}

variable "sns-topic-suffix" {
  default = "-topic"
}

provider "aws" {
  region = var.aws-region
}

resource "aws_sqs_queue" "main" {
  name = "codecommit-notifications-queue"
  delay_seconds = 90
  max_message_size = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

resource "aws_sqs_queue_policy" "sns" {
  queue_url = "${aws_sqs_queue.main.id}"
  policy = "${data.aws_iam_policy_document.sns-sqs-policy.json}"
}

data "aws_iam_policy_document" "sns-sqs-policy" {
  policy_id = "arn:aws:sqs:${var.aws-region}:${data.aws_caller_identity.current.account_id}:testing/SQSDefaultPolicy"

  statement {
    sid = "SubscribeToSNS"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [ "*" ]
    }
    actions = [ "SQS:SendMessage" ]
    resources = [ "${aws_sqs_queue.main.arn}" ]
    condition {
      test = "ArnLike"
      variable = "aws:SourceArn"
      values = [ "arn:aws:sns:${var.aws-region}:${data.aws_caller_identity.current.account_id}:${var.sns-topic-prefix}*${var.sns-topic-suffix}" ]
    }
  }
}

module "cc-example_repo" {
  source = "riboseinc/codecommit-sqs/aws"
  reponame = "example-repo"
  aws-account-id = "${data.aws_caller_identity.current.account_id}"
  sqs-arn = "${aws_sqs_queue.main.arn}"
  sqs-id = "${aws_sqs_queue.main.id}"
  topic-prefix = "${var.sns-topic-prefix}"
  topic-suffix = "${var.sns-topic-suffix}"
  email-sns-arn = "arn:aws:sns:ap-southeast-1:${data.aws_caller_identity.current.account_id}:Default_CloudWatch_Alarms_Topic"

}


output "cc-example_repo-cc-arn" {
  value = "${module.cc-example_repo.cc-arn}"
}
output "cc-example_repo-sns-name" {
  value = "${module.cc-example_repo.sns-name}"
}
output "cc-example_repo-sns-arn" {
  value = "${module.cc-example_repo.sns-arn}"
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}