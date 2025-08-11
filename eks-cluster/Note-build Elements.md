#  iam role
## service EKS, use case eks-cluster
## policy: AmazonEKSClusterPolicy
## role name: 

# Create cluster
## clustername: my-cluster
## cluster role: iam role
## vpc, subnets
## coredns, nodemonitoring, kube-proxy, vpc cni, eks pod identity

# Iam role
## EC2
## policy: AmazonEKSWorkerNodePolicy, AmazonEKS_CNI_Policy, AmazonEC2ContainerRegistryReadOnly

# Node Group
## instancy_type
## min, max, desired
## NG Name
## Node role: Iam role

