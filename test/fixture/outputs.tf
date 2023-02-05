# Test output for your Terraform module
output "kubernetes_cluster" {
  value       = module.terraform-azurerm-aks.kubernetes_cluster
  description = "Module output to test."
  sensitive = true
}

output "log_analytics_workspace" {
  value = module.terraform-azurerm-aks.log_analytics_workspace
}

output "log_analytics_solution" {
  value = module.terraform-azurerm-aks.log_analytics_solution
}

output "user_assigned_identity" {
  value = module.terraform-azurerm-aks.user_assigned_identity
}

output "node_pools" {
  value = module.terraform-azurerm-aks.node_pools
}