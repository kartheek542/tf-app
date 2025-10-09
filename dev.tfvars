vpc_cidr                  = "10.2.0.0/16"
public_subnet_cidr        = "10.2.1.0/24"
private_subnet_cidr_1     = "10.2.2.0/24"
private_subnet_cidr_2     = "10.2.3.0/24"
public_key_path           = "./tf-elk-app-public-key.pub"
app_server_instance_type  = "t2.micro"
database_name             = "elk_rds_db"
database_engine_version   = "15.14"
database_port             = 5432
database_instance_type    = "db.t3.micro"
database_master_username  = "tf_admin"
jump_server_instance_type = "t2.micro"
eks_node_groups = [
  {
    name          = "eks-node-group-1"
    instance_type = "t3.medium"
    disk_size     = 20
    group_size    = 0
  }
]