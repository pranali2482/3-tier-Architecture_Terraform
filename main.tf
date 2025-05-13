
module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr          = var.vpc_cidr
  web_subnet_cidrs  = var.web_subnet_cidrs
  app_subnet_cidrs  = var.app_subnet_cidrs
  db_subnet_cidrs   = var.db_subnet_cidrs
  azs               = var.azs
}

module "security_groups" {
  source   = "./modules/security-group"
  vpc_id   = module.vpc.vpc_id
  web_port = var.web_port
  app_port = var.app_port
  db_port  = var.db_port
}

module "IAM-SSM" {
  source = "./modules/IAM-SSM"
}

module "web_asg_lg" {
  source                       = "./modules/web"
  web_ami_id                       = var.web_ami_id
  web_instance_type                = var.web_instance_type
  web_key_name                     = var.web_key_name
  web_sg_id                    = module.security_groups.web_sg_id
  alb_sg_id                    = module.security_groups.internet_alb_sg_id
  vpc_id                       = module.vpc.vpc_id
  web_subnet_ids               = module.vpc.web_subnet_ids
  web_desired_capacity         = var.web_desired_capacity
  web_min_size                 = var.web_min_size
  web_max_size                 = var.web_max_size
  web_port                     = var.web_port
  instance_profile_name        = module.IAM-SSM.instance_profile_name
  web_target_cpu_utilization   = var.web_target_cpu_utilization
}

module "app_asg_lg" {
  source                       = "./modules/app"
  app_ami_id                       = var.app_ami_id
  app_instance_type                = var.app_instance_type
  app_key_name                     = var.app_key_name
  app_sg_id                    = module.security_groups.app_sg_id
  alb_sg_id                    = module.security_groups.internet_alb_sg_id
  vpc_id                       = module.vpc.vpc_id
  app_subnet_ids               = module.vpc.app_subnet_ids
  app_desired_capacity         = var.app_desired_capacity
  app_min_size                 = var.app_min_size
  app_max_size                 = var.app_max_size
  app_port                     = var.app_port
  instance_profile_name        = module.IAM-SSM.instance_profile_name
  app_target_cpu_utilization   = var.app_target_cpu_utilization
}

module "database" {
  source                = "./modules/database"
  name                  = var.name
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  username              = var.username
  password              = var.password
  database_subnet_ids   = module.vpc.database_subnet_ids
  db_sg_id              = module.security_groups.db_sg_id
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  publicly_accessible   = var.publicly_accessible
}
