output "alb_dns_name" {
  value = "${aws_alb.gatus_alb.dns_name}:8080"
}

output "route53_nameservers" {
    value = aws_route53_zone.labs.name_servers
}