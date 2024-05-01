resource "aws_launch_template" "asg-lt" {
  name                   = "asg_launch_t"
  image_id               = data.aws_ami.amzlinux.id
  instance_type          = var.instancetype
  user_data              = filebase64("/Users/Alex/Desktop/TerraformTesting/TASK/userdata.sh")
  key_name               = aws_key_pair.MacKeyTF.key_name
  depends_on             = [aws_security_group.ec2sg]
  vpc_security_group_ids = [aws_security_group.ec2sg.id]
}

resource "aws_autoscaling_group" "asg" {
  name                = "my-asg"
  vpc_zone_identifier = [aws_subnet.public-1.id, aws_subnet.public-2.id, aws_subnet.public-3.id]
  desired_capacity    = 2
  max_size            = 99
  min_size            = 1
  load_balancers = [aws_elb.elb.id]
  health_check_type   = "ELB"
  health_check_grace_period = 200

  launch_template {
    id = aws_launch_template.asg-lt.id
  }
}

########### Load Balancer
resource "aws_elb" "elb" {
  name            = "terraform-elb"
  security_groups = [aws_security_group.elbsg.id]
  subnets         = [aws_subnet.public-1.id, aws_subnet.public-2.id, aws_subnet.public-3.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port     = 443
    instance_protocol = "http"
    lb_port           = 443
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 4
    unhealthy_threshold = 4
    timeout             = 59
    target              = "HTTP:80/healthcheck.html"
    interval            = 60
  }

  tags = {
    Name = "terraform-elb"
  }
}


resource "aws_autoscaling_attachment" "asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  elb                    = aws_elb.elb.id
}



