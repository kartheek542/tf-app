module "network" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/network?ref=main"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}