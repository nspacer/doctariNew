resource "aws_security_group" "publicEC2Security" {
  name   = "PublicSecurityGroup"
  vpc_id = var.vpc_id
  dynamic "ingress" {
    for_each = var.sgPortsPublic
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      cidr_blocks     = ["152.89.162.253/32"]
    }
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "privateEC2Security" {
  name   = "PrivateSecurityGroup"
  vpc_id = var.vpc_id
  ingress {
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
    security_groups = [aws_security_group.publicEC2Security.id]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "database-security-group" {
  name   = "dataBaseSecurityGroup"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 3306
    protocol    = "tcp"
    to_port     = 3306
    security_groups = [aws_security_group.privateEC2Security.id,aws_security_group.publicEC2Security.id]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}