
data "aws_instance" "PublicInstance" {
  instance_tags = {
    Name = "EC2-Demo"
  }
  instance_id = "i-0f7647a7f75d5900a"
}

resource "aws_ebs_volume" "demoVolume" {
  availability_zone = data.aws_instance.PublicInstance.availability_zone
  size              = 1
  tags = {
    Name = "dataVolume"
  }
}

resource "aws_volume_attachment" "volumeAttachement" {
  device_name = "/dev/sdc"
  instance_id = data.aws_instance.PublicInstance.id
  volume_id   = aws_ebs_volume.demoVolume.id
  skip_destroy = false
}

