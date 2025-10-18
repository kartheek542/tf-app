module "public-app-server" {
  source = "git::https://github.com/kartheek542/tf-modules.git//aws-modules/elk-app/public-app-server?ref=main"

  instance_type         = var.app_server_instance_type
  subnet_id             = module.network.public_subnet_id
  security_group_id     = module.public-ec2-sg.sg_id
  instance_profile_name = module.jump-server-iam-role.instance_profile_name[0]
  key_name              = module.my-key-pair.key_name
  depends_on            = [module.network, module.jump-server-iam-role]
  user_data_script      = var.user_data_script
}
