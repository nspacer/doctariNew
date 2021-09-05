module "aws_database" {
  source = "./module/database"
  database-security-group = var.database-security-group
  database-user-name = var.database-user-name
  database_master_password = var.database_master_password
  vpc_id = var.vpc_id
}