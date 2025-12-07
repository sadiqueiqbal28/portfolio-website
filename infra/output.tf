output "bastion_public_ip" {
  value = aws_instance.bastion_server.public_ip
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins_server.public_ip
}

# output "eks_cluster_name" {
#   value = module.eks.cluster_name
# }

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}