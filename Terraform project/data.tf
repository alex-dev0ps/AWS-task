data "aws_ami" "amzlinux" {
  most_recent = true
  owners = ["137112412989"]
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    filter {
        name   = "name"
        values = ["al2023-ami-2023.4.20240416.0-kernel-6.1-x*"]
    }    
}


data "aws_availability_zones" "av-azs" {
  state = "available"
}
