data "aws_ami" "amazon-ami-vhugo" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.20190603-x86_64-ebs"]
  }

  owners = ["591542846629"]
}