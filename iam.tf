resource "aws_iam_access_key" "s3-backup-ro" {
  provider   = "aws.cloud"
  user       = "s3-backup-ro"
  depends_on = ["aws_iam_user.s3-backup-ro"]
}

resource "aws_iam_user" "s3-backup-ro" {
  provider = "aws.cloud"
  name     = "s3-backup-ro"
}

resource "aws_iam_user_policy" "s3-backup-ro" {
  provider = "aws.cloud"
  name     = "s3-backup-ro"
  user     = "${aws_iam_user.s3-backup-ro.name}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

output "acccess_key" {
  value = "${aws_iam_access_key.s3-backup-ro.id}"
}

