resource "aws_acm_certificate" "cert" {
    domain_name = "tm.labs.abdulbasiddevops.uk"
    validation_method = "DNS"
    
    lifecycle {
    create_before_destroy = true
  }
}