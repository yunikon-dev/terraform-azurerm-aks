# Test output for your Terraform module
output "terraform-azurerm-aks-name" {
  value       = module.terraform-azurerm-aks.cluster_name
  description = "Module output to test."
}