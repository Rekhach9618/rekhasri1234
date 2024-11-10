provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

# Create an IAM user
resource "aws_iam_user" "example_user" {
  name = "example_user"
}

# Create an IAM group
resource "aws_iam_group" "example_group" {
  name = "example_group"
}

# Create a policy
resource "aws_iam_policy" "example_policy" {
  name        = "example_policy"
  description = "A simple policy to allow S3 access"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:*"
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to the group
resource "aws_iam_policy_attachment" "example_attachment" {
  name       = "example_attachment"
  policy_arn = aws_iam_policy.example_policy.arn
  groups     = [aws_iam_group.example_group.name]
}

# Add the user to the group
resource "aws_iam_user_group_membership" "example_membership" {
  user   = aws_iam_user.example_user.name
  groups = [aws_iam_group.example_group.name]
}

# Create an IAM access key for the user
resource "aws_iam_access_key" "example_access_key" {
  user = aws_iam_user.example_user.name
}

# Output the access key ID
output "user_access_key" {
  value = aws_iam_access_key.example_access_key.id
}
