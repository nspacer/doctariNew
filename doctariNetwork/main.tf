module "aws_virtual_private_network" {
  source   = "./module/vpc"
  tags     = merge(var.tags, { Name = var.vpc_name })
  vpc_name = "myVPC"
}

module "aws_security_group" {
  source = "./module/securityGroup"
  vpc_id = module.aws_virtual_private_network.vpc_id
}

module "aws_instance" {
  depends_on = [module.aws_virtual_private_network]
  source                   = "./module/instance"
  AWS_REGION               = var.AWS_REGION
  INSTANCE_TYPE            = var.INSTANCE_TYPE
  public_security_group_id = module.aws_security_group.public_security_group_id
  vpc_id                   = module.aws_virtual_private_network.vpc_id
  //vpc_public_subnet_id = []
  private_security_group_id = module.aws_security_group.private_security_group_id
}
