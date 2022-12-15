# Test output for your Terraform module
output "terraform-azurerm-aks_name" {
  value       = module.terraform-azurerm-aks.name
  description = "Module output to test."
}