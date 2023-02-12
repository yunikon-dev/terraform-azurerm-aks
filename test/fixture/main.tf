# Test code for your Terraform module
resource "azurerm_resource_group" "main" {
  name     = "test-terraform-azurerm-aks"
  location = "westeurope"
}

resource "azurerm_virtual_network" "main" {
  name                = "test-terraform-azurerm-aks-vnet"
  address_space       = ["172.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["172.0.1.0/24"]
}

module "terraform-azurerm-aks" {
  source = "../.."

  resource_group_name        = azurerm_resource_group.main.name
  name                       = "testakscluster891104"
  location                   = azurerm_resource_group.main.location
  dns_prefix                 = "testjeaks"
  container_registry_enabled = false
  public_network_access_enabled = true

  default_node_pool = {
    vnet_subnet_id      = azurerm_subnet.main.id
    enable_auto_scaling = true
    node_count          = 1
  }

  azure_active_directory_role_based_access_control_enabled = true

  azure_active_directory_role_based_access_control = {
    managed            = true
    azure_rbac_enabled = true
  }

  azuread_groups = ["Testing", "Testing2"]
}