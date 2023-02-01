# Test code for your Terraform module
resource "azurerm_resource_group" "main" {
  name     = "test-terraform-azurerm-aks"
  location = "westeurope"
}

module "terraform-azurerm-aks" {
  source = "github.com/yunikon-dev/terraform-azurerm-aks"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  
}