# Create Database Subnet Group
# terraform aws db subnet group
resource "aws_db_subnet_group" "database-subnet-group" {
  name         = "database subnets"
  subnet_ids  = var.database-subnet-ids
  description  = "Subnets for Database Instance"

  tags   = {
    Name = "Database Subnets"
  }
}

# Get the Latest DB Snapshot
# terraform aws data db snapshot


/*data "aws_db_snapshot" "latest-db-snapshot" {
  db_snapshot_identifier = var.database-snapshot-identifier
  most_recent            = true
  snapshot_type          = "manual"
}*/



# Create Database Instance Restored from DB Snapshots
# terraform aws db instance
resource "aws_db_instance" "database-instance" {
  instance_class          = var.database-instance-class
  skip_final_snapshot     = true
  //availability_zone       = "eu-central-1b"
  identifier              = var.database-instance-identifier
  db_subnet_group_name    = aws_db_subnet_group.database-subnet-group.name
  multi_az                = var.multi-az-deployment
  vpc_security_group_ids  = [var.database-security-group]
  username                = var.database-user-name
  password                = var.database_master_password
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.7.19"
  port                    = "3306"
}


resource "aws_ssm_parameter" "secret" {
  name        = "/production/database/password/master"
  description = "The parameter description"
  type        = "SecureString"
  value       = var.database_master_password

  tags = {
    environment = "production"
  }
}

resource "aws_ssm_parameter" "secret2" {
  name        = "/production/database/username/master"
  description = "The parameter description"
  type        = "SecureString"
  value       = var.database-user-name

  tags = {
    environment = "production"
  }
}
