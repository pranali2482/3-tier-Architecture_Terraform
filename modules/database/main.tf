resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.database_subnet_ids

  tags = {
    Name = "${var.name}-subnet-group"
  }
}

resource "aws_db_instance" "rds" {
  identifier              = "${var.name}-rds"
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  username                = var.username
  password                = var.password
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [var.db_sg_id]
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = var.max_allocated_storage
  storage_type            = var.storage_type
  publicly_accessible     = var.publicly_accessible
  skip_final_snapshot     = true
  deletion_protection     = false

  tags = {
    Name = "${var.name}-rds"
  }
}
