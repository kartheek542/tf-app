module "jump-server-iam-role" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/iam-role?ref=main"

  name             = "jump-server-iam-role"
  instance_profile = true
  eks_cluster_arns = [module.eks_cluster.cluster_arn]
  depends_on       = [module.eks_cluster]
}

module "eks_access" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/eks-access?ref=main"

  cluster_name = module.eks_cluster.cluster_name
  roles        = [module.jump-server-iam-role.arn]
}