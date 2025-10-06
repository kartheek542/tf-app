module "network" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/network?ref=main"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "app-server" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/app-server?ref=main"

  public_key_path = var.public_key_path
  instance_type   = var.app_server_instance_type
  subnet_id       = module.network.public_subnet_id
}

module "database" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/database?ref=main"

  db_name            = var.database_name
  db_engine          = "postgres"
  db_version         = var.database_engine_version
  db_port            = var.database_port
  instance_class     = var.database_instance_type
  master_username    = var.database_master_username
  private_subnet_ids = [module.network.private_subnet_id]
  public_subnet_id   = module.network.public_subnet_id
}