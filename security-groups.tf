module "private-ec2-sg" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/security-group?ref=main"

  name           = "private-ec2-sg"
  vpc_id         = module.network.vpc_id
  allowed_ranges = [var.private_subnet_cidr_1, var.private_subnet_cidr_2, var.public_subnet_cidr]
}

module "public-ec2-sg" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/security-group?ref=main"

  name           = "public-ec2-sg"
  vpc_id         = module.network.vpc_id
  allowed_ranges = [var.private_subnet_cidr_1, var.private_subnet_cidr_2, var.public_subnet_cidr]
  public         = true
}

