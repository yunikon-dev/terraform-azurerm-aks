# Test code for your Terraform module
resource "azurerm_resource_group" "main" {
  name     = "test-terraform-azurerm-aks"
  location = "westeurope"
}

resource "azurerm_virtual_network" "main" {
  name                = "test-terraform-azurerm-aks-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

module "terraform-azurerm-aks" {
  source = "github.com/yunikon-dev/terraform-azurerm-aks"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  dns_prefix          = "testjeaks"
  default_node_pool_vnet_subnet_id = azurerm_subnet.main.id
}