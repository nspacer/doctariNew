data "aws_subnet_ids" "myPublicSubnet" {
  vpc_id = var.vpc_id
  tags = {
    Tier = "public"
  }
}

data "aws_subnet_ids" "myPrivateSubnet" {
  vpc_id = var.vpc_id
  tags = {
    Tier = "private"
  }
}

resource "aws_instance" "myEC2" {
  for_each      = data.aws_subnet_ids.myPublicSubnet.ids
  ami                    = lookup(var.AMIS, var.AWS_REGION)
  instance_type          = var.INSTANCE_TYPE
  vpc_security_group_ids = [var.public_security_group_id]
  subnet_id              = each.value
  tags = {
    Name = "EC2-Demo"
  }
  key_name  = aws_key_pair.mykey.key_name
  //user_data = file("${path.module}/userdata.tpl")
}

resource "aws_instance" "myPrivateEC2" {
  for_each      = data.aws_subnet_ids.myPrivateSubnet.ids
  subnet_id              = each.value
  ami                    = lookup(var.AMIS, var.AWS_REGION)
  instance_type          = var.INSTANCE_TYPE
  vpc_security_group_ids = [var.private_security_group_id]

  tags = {
    Name = "Private-EC2"
  }

  key_name = aws_key_pair.mykey.key_name
}



/*resource "aws_eip" "elasticIP" {
  vpc = true
  tags = {
    Name = "ElasticIP"
  }
}

resource "aws_eip_association" "eipAssociation" {
  count = lenght(aws_instance.myEC2.id)
  instance_id   = aws_instance.myEC2[count.index]
  allocation_id = aws_eip.elasticIP.id
}*/

