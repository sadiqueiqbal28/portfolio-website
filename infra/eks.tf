module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "master-nodes"
  kubernetes_version = "1.34"

  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  vpc_id                   = aws_vpc.prod_vpc.id
  subnet_ids               = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_1b.id]
  control_plane_subnet_ids = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_1b.id]

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    worker-nodes = {

      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t2.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 1
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}