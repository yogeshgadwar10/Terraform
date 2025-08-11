data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = [var.trusted_service]
    }

    actions = ["sts:AssumeRole"]
  }
}
