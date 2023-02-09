# List of outputs
output "kubernetes_cluster" {
  value       = azurerm_kubernetes_cluster.main
  sensitive   = true
  description = "Details of the Kubernetes Cluster."
}

output "cluster_name" {
  value       = azurerm_kubernetes_cluster.main.name
  description = "Name of the Kubernetes Cluster."
}

output "log_analytics_workspace" {
  value       = try(azurerm_log_analytics_workspace.main[0], null)
  description = "Details of the Log Analytics Workspace."
}

output "log_analytics_solution" {
  value       = try(azurerm_log_analytics_solution.main[0], null)
  description = "Details of the Log Analytics Solution."
}

output "user_assigned_identity" {
  value       = azurerm_user_assigned_identity.main
  description = "Details of the Kubernetes Cluster's User Assigned Identity."
}

output "node_pools" {
  value       = try(values(azurerm_kubernetes_cluster_node_pool.main)[*], null)
  description = "Details of all additional Node Pools."
}

output "azurerm_container_registry" {
  value       = azurerm_container_registry.main
  description = "Details of the Container Registry."
}

output "azurerm_private_endpoint" {
  value       = try(azurerm_private_endpoint.main, null)
  description = "Details of the Private Endpoint."
}

output "azurerm_private_dns_zone" {
  value       = try(azurerm_private_dns_zone.main, null)
  description = "Details of the Private DNS Zone."
}

output "tls_private_key" {
  value       = tls_private_key.ssh
  description = "Details of the generated TLS Private Key."
}