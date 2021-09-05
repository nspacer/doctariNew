resource "aws_key_pair" "mykey" {
  public_key = file(var.AWS_PUBLIC_KEY)
  key_name   = "myKey"
}