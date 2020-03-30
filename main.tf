# Modules ============
module "vpc" {
  source = "./modules/vpc"
  name = "vhugo"
}

module "ami" {
  source = "./modules/ami"
}

module "key" {
  source = "./modules/security"
}

module "security_group" {
  source = "./modules/securitygroup"

  vpc_id = module.vpc.vpc_id
}

#=====================================================#

variable "instance_type" {
  type = string
  default = "t2.micro"
}

resource "aws_instance" "web" {
  ami           = module.ami.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [module.security_group.sg_id]

  key_name = module.key.key_name

  subnet_id = module.vpc.vpc_subnet

  tags = {
    Name = "ec2-vhugo-terraform"
  }
}

output "security_group_id" {
  value = module.security_group.sg_id
}

output "instance_ip4" {
  value = aws_instance.web.public_ip
}

