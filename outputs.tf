output "aws_route53_record" {
  description = "The Route 53 entries for the domain."
  value       = flatten(aws_route53_record.eks_domain_cert_validation_dns.*)
}

output "oidc_thumbprint" {
  description = "The OIDC thumbprint obtained."
  value       = data.tls_certificate.cluster.certificates.0.sha1_fingerprint
}