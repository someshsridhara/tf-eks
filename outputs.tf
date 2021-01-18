
output "eks_cluster_name" {
  description = "The cluster name created in EKS."
  value       = module.eks-cluster.cluster_id
}

output "eks_cluster_version" {
  description = "The version of the cluster created in EKS."
  value       = module.eks-cluster.cluster_version
}

output "oidc_thumbprint" {
  description = "The OIDC thumbprint obtained."
  value       = data.tls_certificate.cluster.certificates.0.sha1_fingerprint
}