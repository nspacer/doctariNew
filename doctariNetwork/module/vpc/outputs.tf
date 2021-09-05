output "vpc_id" {
  value = aws_vpc.myVPC.id
}
/*
output "vpc_public_subnet_id" {
  value = aws_subnet.myPublicSubnet.*.id
}*/