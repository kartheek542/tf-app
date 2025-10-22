module "network" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/network?ref=main"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidrs = [var.private_subnet_cidr_1, var.private_subnet_cidr_2]
}


module "my-key-pair" {
  source          = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/key-pair?ref=main"
  name            = "elk-key-pair"
  public_key_path = var.public_key_path
}


module "database" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/database?ref=main"

  db_name            = var.database_name
  db_engine          = "postgres"
  db_version         = var.database_engine_version
  db_port            = var.database_port
  instance_class     = var.database_instance_type
  master_username    = var.database_master_username
  private_subnet_ids = module.network.private_subnet_ids
  public_subnet_id   = module.network.public_subnet_id
  security_group_id  = module.private-ec2-sg.sg_id

  depends_on = [module.network]
}