variable "subent1" {
  
}
variable "subnet2" {
  
}
variable "min_node" {
  
}
variable "max_node" {
  
}
output "cluster_name" {
  value = aws_eks_cluster.eks.name
}