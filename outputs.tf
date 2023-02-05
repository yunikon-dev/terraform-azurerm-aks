# List of outputs
output "kubernetes_cluster" {
  value       = azurerm_kubernetes_cluster.main
  description = "Details of the Azure Kubernetes Service."
  sensitive   = true
}

output "log_analytics_workspace" {
  value       = try(azurerm_log_analytics_workspace.main[0], null)
  description = ""
}

output "log_analytics_solution" {
  value = try(azurerm_log_analytics_solution.main[0], null)
}

output "user_assigned_identity" {
  value = azurerm_user_assigned_identity.main
}

output "node_pools" {
  value = try(values(azurerm_kubernetes_cluster_node_pool.main)[*], null)
}