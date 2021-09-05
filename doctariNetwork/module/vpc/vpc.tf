data "aws_availability_zones" "available" {
}

resource "aws_vpc" "myVPC" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = merge(var.tags, { Name = var.vpc_name })
}

resource "aws_subnet" "myPublicSubnet" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.myVPC.cidr_block, 8, var.az_count + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.myVPC.id
  map_public_ip_on_launch = true

  tags = merge(var.tags, { Name = "${var.vpc_name}-public-${element(data.aws_availability_zones.available.names, count.index)}" }, { Tier = "public" })
}

resource "aws_subnet" "myPrivateSubnet" {
  count             = var.az_count
  cidr_block        = cidrsubnet(aws_vpc.myVPC.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.myVPC.id
  map_public_ip_on_launch = false

  tags = merge(var.tags, { Name = "${var.vpc_name}-private-${element(data.aws_availability_zones.available.names, count.index)}" }, { Tier = "private" })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myVPC.id
  tags = {
    Name = "myIGW"
  }
}

resource "aws_route_table" "PublicRoute" {
  vpc_id = aws_vpc.myVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public"
  }
}

resource "aws_route_table_association" "public" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.myPublicSubnet.*.id, count.index)
  route_table_id = element(aws_route_table.PublicRoute.*.id, count.index)
}

/*# Create a NAT gateway with an EIP for each private subnet to get internet connectivity
resource "aws_eip" "gw" {
  count      = var.az_count
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "gw" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.myPrivateSubnet.*.id, count.index)
  allocation_id = element(aws_eip.gw.*.id, count.index)
}*/


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.myVPC.id
  route {
    cidr_block     = "0.0.0.0/0"
    //nat_gateway_id = element(aws_nat_gateway.gw.*.id, count.index)
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Private"
  }
}

# Explicitely associate the newly created route tables to the private subnets (so they don't default to the main route table)
resource "aws_route_table_association" "private" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.myPrivateSubnet.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

resource "aws_s3_bucket" "logforspacerhgtrfef" {
  bucket = "logforspacerhgtrfef"
}

resource "aws_flow_log" "example" {
  traffic_type         = "ALL"
  log_destination      = aws_s3_bucket.logforspacerhgtrfef.arn
  log_destination_type = "s3"
  vpc_id               = aws_vpc.myVPC.id
}
