variable "vpc_cidr" {
  default = ""
}
variable "public_subnet_cidr" {
  default = ""
}
variable "private_subnet_cidr_1" {
  default = ""
}
variable "private_subnet_cidr_2" {
  default = ""
}
variable "public_key_path" {
  default = ""
}
variable "app_server_instance_type" {
  default = ""
}
variable "database_name" {
  default = ""
}
variable "database_engine_version" {
  default = ""
}
variable "database_port" {
  default = 5432
}
variable "database_instance_type" {
  default = ""
}
variable "database_master_username" {
  default = ""
}
variable "jump_server_instance_type" {}
variable "eks_node_groups" {
}
variable "eks_allowed_ports" {
  default = [443]
}

variable "user_data_script" {}