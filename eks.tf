module "eks_cluster" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/k8s?ref=main"

  cluster_subnet_ids = module.network.private_subnet_ids
  cluster_version    = "1.31"
  pods_ip_cidr       = "192.168.0.0/16"
  node_groups        = var.eks_node_groups
  depends_on         = [module.network]
  security_group_ids = [module.private-ec2-sg.sg_id]
  namespace          = "elk-kar"
  service_account    = "kar-aws"
}