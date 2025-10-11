module "network" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/network?ref=main"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidrs = [var.private_subnet_cidr_1, var.private_subnet_cidr_2]
}

module "general-iam-role" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/iam-role?ref=main"

  name             = "general-iam-role"
  instance_profile = true
}

module "jump-server-iam-role" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/iam-role?ref=main"

  name             = "jump-server-iam-role"
  instance_profile = true
  # eks_cluster_arns = []
}

module "my-key-pair" {
  source          = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/key-pair?ref=main"
  name            = "elk-key-pair"
  public_key_path = var.public_key_path
}

module "public-app-server" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/public-app-server?ref=main"

  instance_type         = var.app_server_instance_type
  subnet_id             = module.network.public_subnet_id
  security_group_id     = module.public-ec2-sg.sg_id
  instance_profile_name = module.jump-server-iam-role.instance_profile_name[0]
  key_name              = module.my-key-pair.key_name
}

module "private-app-server" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/private-app-server?ref=main"

  instance_type         = var.app_server_instance_type
  subnet_id             = module.network.private_subnet_ids[0]
  security_group_id     = module.private-ec2-sg.sg_id
  instance_profile_name = module.general-iam-role.instance_profile_name[0]
  key_name              = module.my-key-pair.key_name
}

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

# 
# module "database" {
#   source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/database?ref=main"
# 
#   db_name            = var.database_name
#   db_engine          = "postgres"
#   db_version         = var.database_engine_version
#   db_port            = var.database_port
#   instance_class     = var.database_instance_type
#   master_username    = var.database_master_username
#   private_subnet_ids = module.network.private_subnet_ids
#   public_subnet_id   = module.network.public_subnet_id
# }

# module "eks_cluster" {
#   source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/k8s?ref=main"
# 
#   cluster_subnet_ids = module.network.private_subnet_ids
#   cluster_version    = "1.31"
#   pods_ip_cidr       = "192.168.0.0/16"
#   node_groups        = var.eks_node_groups
#   depends_on         = [module.network]
# }
# 
# module "jump-server" {
#   source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/jump-server?ref=main"
# 
#   public_key_path = var.public_key_path
#   instance_type   = var.jump_server_instance_type
#   subnet_id       = module.network.public_subnet_id
#   eks_cluster_arn = module.eks_cluster.cluster_arn
#   depends_on      = [module.eks_cluster]
# }
# 
# resource "aws_vpc_security_group_ingress_rule" "jump_server_eks_cluster_sg_rules" {
#   count             = length(var.eks_allowed_ports)
#   security_group_id = module.eks_cluster.security_group_id
#   cidr_ipv4         = "${module.jump-server.private_ip}/32"
#   from_port         = var.eks_allowed_ports[count.index]
#   to_port           = var.eks_allowed_ports[count.index]
#   ip_protocol       = "tcp"
# }