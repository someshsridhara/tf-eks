# Get DNS Zone
data "aws_route53_zone" "base_domain" {
  name = var.dns_base_domain
}

# create AWS-issued SSL certificate
resource "aws_acm_certificate" "eks_domain_cert" {
  domain_name               = var.dns_base_domain
  subject_alternative_names = ["*.${var.dns_base_domain}"]
  validation_method         = "DNS"

  tags = {
    Name            = var.dns_base_domain
    env = var.env_tag
  }
}

resource "aws_route53_record" "eks_domain_cert_validation_dns" {
 for_each = {
    for dvo in aws_acm_certificate.eks_domain_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
      }
    }
  name            = each.value.name
  records         = [each.value.record]
  zone_id = data.aws_route53_zone.base_domain.id
  type            = each.value.type
  ttl     = 60
  allow_overwrite = true

}

resource "aws_acm_certificate_validation" "eks_domain_cert_validation" {
  certificate_arn         = aws_acm_certificate.eks_domain_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.eks_domain_cert_validation_dns : record.fqdn]
}