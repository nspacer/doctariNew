output "public_security_group_id" {
  value = aws_security_group.publicEC2Security.id
}

output "private_security_group_id" {
  value = aws_security_group.privateEC2Security.id
}

output "database-security-group" {
  value = aws_security_group.database-security-group.id
}