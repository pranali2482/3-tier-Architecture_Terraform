
# General VPC
region            = "ap-south-1"
vpc_cidr          = "10.0.0.0/16"
web_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
app_subnet_cidrs  = ["10.0.3.0/24", "10.0.4.0/24"]
db_subnet_cidrs   = ["10.0.5.0/24", "10.0.6.0/24"]
azs               = ["ap-south-1a", "ap-south-1b"]

# Security Groups
web_port = 3000
app_port = 8080
db_port  = 3306

# Web ASG
web_ami_id                   = "ami-0e35ddab05955cf57"
web_instance_type            = "t2.micro"
web_key_name                 = "mykey"
web_desired_capacity     = 2
web_min_size             = 2
web_max_size             = 4
web_target_cpu_utilization = 60

# App ASG
app_ami_id                   = "ami-0e35ddab05955cf57"
app_instance_type            = "t2.micro"
app_key_name                 = "mykey"
app_desired_capacity     = 2
app_min_size             = 2
app_max_size             = 4
app_target_cpu_utilization = 60

# Database
name                  = "mydb"
engine                = "mysql"
engine_version        = "8.0"
instance_class        = "db.t3.micro"
username              = "admin"
password              = "admin1234"
allocated_storage     = 10
max_allocated_storage = 50
storage_type          = "gp2"
publicly_accessible   = false
