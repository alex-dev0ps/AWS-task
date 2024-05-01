resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "wordpress.smsinvesting.com"
  type    = "A"
  alias {
    name                   = aws_elb.elb.dns_name
    zone_id                = aws_elb.elb.zone_id
    evaluate_target_health = true
  }
}

# resource "aws_route53_record" "endpoint1" {
#   zone_id = var.zone_id
#   name    = "reader1.smsinvesting.com"
#   type    = "CNAME"
#   ttl = "300"
#   records = [aws_rds_cluster_instance.test1.endpoint]
# }

# resource "aws_route53_record" "endpoint2" {
#   zone_id = var.zone_id
#   name    = "reader2.smsinvesting.com"
#   type    = "CNAME"
#   ttl = "300"
#   records = [aws_rds_cluster_instance.test2.endpoint]
# }

# resource "aws_route53_record" "endpoint3" {
#   zone_id = var.zone_id
#   name    = "reader3.smsinvesting.com"
#   type    = "CNAME"
#   ttl = "300"
#   records = [aws_rds_cluster_instance.test3.endpoint]
# }

# resource "aws_route53_record" "endpoint4" {
#   zone_id = var.zone_id
#   name    = "reader4.smsinvesting.com"
#   type    = "CNAME"
#   ttl = "300"
#   records = [aws_rds_cluster_instance.test4.endpoint]
# }