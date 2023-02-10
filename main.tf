# Generate an SSH key
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create a User Assigned Identity for the Kubernetes Cluster
resource "azurerm_user_assigned_identity" "main" {
  name                = "${var.name}-id"
  location            = coalesce(local.location, "westeurope")
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Read any given Azure AD Groups to extract their object_id
data "azuread_group" "main" {
  for_each = toset(var.azuread_groups)

  display_name     = each.key
  security_enabled = true
}

# Create the Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "main" {
  name                                = var.name
  location                            = local.location
  resource_group_name                 = var.resource_group_name
  node_resource_group                 = coalesce(var.node_resource_group, "${var.resource_group_name}-resources")
  automatic_channel_upgrade           = var.automatic_channel_upgrade
  azure_policy_enabled                = var.azure_policy_enabled
  disk_encryption_set_id              = var.disk_encryption_set_id
  dns_prefix                          = var.dns_prefix
  http_application_routing_enabled    = var.http_application_routing_enabled
  kubernetes_version                  = var.kubernetes_version
  local_account_disabled              = var.local_account_disabled
  oidc_issuer_enabled                 = var.oidc_issuer_enabled
  open_service_mesh_enabled           = var.open_service_mesh_enabled
  private_cluster_enabled             = var.private_cluster_enabled
  public_network_access_enabled       = var.public_network_access_enabled
  private_cluster_public_fqdn_enabled = var.private_cluster_public_fqdn_enabled
  private_dns_zone_id                 = try(azurerm_private_dns_zone.main[0].id, var.private_dns_zone_id, null)
  role_based_access_control_enabled   = var.azure_active_directory_role_based_access_control["azure_rbac_enabled"] ? true : coalesce(var.role_based_access_control_enabled, false)
  sku_tier                            = var.sku_tier
  tags                                = var.tags

  # Preview features
  image_cleaner_enabled        = var.image_cleaner_enabled
  image_cleaner_interval_hours = var.image_cleaner_enabled ? var.image_cleaner_interval_hours : null
  workload_identity_enabled    = var.workload_identity_enabled

  default_node_pool {
    name                         = var.default_node_pool["name"]
    vm_size                      = var.default_node_pool["vm_size"]
    enable_auto_scaling          = var.default_node_pool["enable_auto_scaling"]
    enable_host_encryption       = var.default_node_pool["enable_host_encryption"]
    enable_node_public_ip        = var.default_node_pool["enable_node_public_ip"]
    node_count                   = var.default_node_pool["enable_auto_scaling"] ? null : coalesce(var.default_node_pool["node_count"], 1)
    min_count                    = var.default_node_pool["enable_auto_scaling"] ? coalesce(var.default_node_pool["min_count"], 1) : null
    max_count                    = var.default_node_pool["enable_auto_scaling"] ? coalesce(var.default_node_pool["max_count"], var.default_node_pool["min_count"] + 1) : null
    max_pods                     = var.default_node_pool["max_pods"]
    node_labels                  = var.default_node_pool["node_labels"]
    node_taints                  = var.default_node_pool["node_taints"]
    only_critical_addons_enabled = var.default_node_pool["only_critical_addons_enabled"]
    orchestrator_version         = var.default_node_pool["orchestrator_version"]
    os_disk_size_gb              = var.default_node_pool["os_disk_size_gb"]
    os_disk_type                 = var.default_node_pool["os_disk_type"]
    pod_subnet_id                = var.default_node_pool["pod_subnet_id"]
    scale_down_mode              = var.default_node_pool["scale_down_mode"]
    tags                         = merge(var.tags, var.default_node_pool["tags"])
    type                         = "VirtualMachineScaleSets"
    ultra_ssd_enabled            = var.default_node_pool["ultra_ssd_enabled"]
    vnet_subnet_id               = var.default_node_pool["vnet_subnet_id"]
    zones                        = var.default_node_pool["zones"]
  }

  dynamic "auto_scaler_profile" {
    for_each = var.default_node_pool["enable_auto_scaling"] || var.default_node_pool["enable_auto_scaling"] ? ["auto_scaler_profile"] : []

    content {
      balance_similar_node_groups      = var.auto_scaler_profile["balance_similar_node_groups"]
      empty_bulk_delete_max            = var.auto_scaler_profile["empty_bulk_delete_max"]
      expander                         = var.auto_scaler_profile["expander"]
      max_graceful_termination_sec     = var.auto_scaler_profile["max_graceful_termination_sec"]
      max_node_provisioning_time       = var.auto_scaler_profile["max_node_provisioning_time"]
      max_unready_nodes                = var.auto_scaler_profile["max_unready_nodes"]
      max_unready_percentage           = var.auto_scaler_profile["max_unready_percentage"]
      new_pod_scale_up_delay           = var.auto_scaler_profile["new_pod_scale_up_delay"]
      scale_down_delay_after_add       = var.auto_scaler_profile["scale_down_delay_after_add"]
      scale_down_delay_after_delete    = var.auto_scaler_profile["scale_down_delay_after_delete"]
      scale_down_delay_after_failure   = var.auto_scaler_profile["scale_down_delay_after_failure"]
      scale_down_unneeded              = var.auto_scaler_profile["scale_down_unneeded"]
      scale_down_unready               = var.auto_scaler_profile["scale_down_unready"]
      scale_down_utilization_threshold = var.auto_scaler_profile["scale_down_utilization_threshold"]
      scan_interval                    = var.auto_scaler_profile["scan_interval"]
      skip_nodes_with_local_storage    = var.auto_scaler_profile["skip_nodes_with_local_storage"]
      skip_nodes_with_system_pods      = var.auto_scaler_profile["skip_nodes_with_system_pods"]
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.azure_active_directory_role_based_access_control_enabled ? ["azure_active_directory_role_based_access_control"] : []

    content {
      managed   = var.azure_active_directory_role_based_access_control["managed"]
      tenant_id = var.azure_active_directory_role_based_access_control["tenant_id"]
      # If managed is set to `true`
      admin_group_object_ids = var.azure_active_directory_role_based_access_control["managed"] ? [for group in data.azuread_group.main : group.object_id] : null
      azure_rbac_enabled     = var.azure_active_directory_role_based_access_control["managed"] ? var.azure_active_directory_role_based_access_control["azure_rbac_enabled"] : null
      # If managed is set to `false`
      client_app_id     = !var.azure_active_directory_role_based_access_control["managed"] ? var.azure_active_directory_role_based_access_control["client_app_id"] : null
      server_app_id     = !var.azure_active_directory_role_based_access_control["managed"] ? var.azure_active_directory_role_based_access_control["server_app_id"] : null
      server_app_secret = !var.azure_active_directory_role_based_access_control["managed"] ? var.azure_active_directory_role_based_access_control["server_app_secret"] : null
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = concat(var.identity_ids, [time_sleep.aks_creation_delay.triggers["id"]])
  }

  dynamic "ingress_application_gateway" {
    for_each = var.ingress_application_gateway != null ? ["ingress_application_gateway"] : []

    content {
      gateway_id   = var.ingress_application_gateway["gateway_id"]
      gateway_name = var.ingress_application_gateway["gateway_name"]
      subnet_cidr  = var.ingress_application_gateway["subnet_cidr"]
      subnet_id    = var.ingress_application_gateway["subnet_id"]
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = var.key_vault_secrets_provider != null ? ["key_vault_secrets_provider"] : []

    content {
      secret_rotation_enabled  = var.key_vault_secrets_provider["secret_rotation_enabled"]
      secret_rotation_interval = var.key_vault_secrets_provider["secret_rotation_interval"]
    }
  }

  linux_profile {
    admin_username = var.linux_profile["admin_username"]
    ssh_key {
      key_data = var.linux_profile["admin_username"] != null ? replace(coalesce(var.linux_profile["key_data"], tls_private_key.ssh.public_key_openssh), "\n", "") : null
    }
  }

  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? ["maintenance_window"] : []

    content {
      dynamic "allowed" {
        for_each = var.maintenance_window.allowed

        content {
          day   = allowed.value.day
          hours = allowed.value.hours
        }
      }

      dynamic "not_allowed" {
        for_each = var.maintenance_window.not_allowed

        content {
          end   = not_allowed.value.end
          start = not_allowed.value.start
        }
      }
    }
  }

  dynamic "api_server_access_profile" {
    for_each = var.public_network_access_enabled || var.api_server_access_profile != null ? ["api_server_access_profile"] : []

    content {
      authorized_ip_ranges     = var.public_network_access_enabled ? concat(["0.0.0.0/32"], try(var.api_server_access_profile["authorized_ip_ranges"], [])) : var.api_server_access_profile["authorized_ip_ranges"]
      subnet_id                = var.api_server_access_profile["subnet_id"]
      vnet_integration_enabled = var.preview_features_enabled && var.api_server_access_profile["vnet_integration_enabled"] != null ? var.api_server_access_profile["vnet_integration_enabled"] : false
    }
  }

  dynamic "microsoft_defender" {
    for_each = var.microsoft_defender_enabled ? ["microsoft_defender"] : []
    content {
      log_analytics_workspace_id = try(azurerm_log_analytics_workspace.main[0].id, null)
    }
  }

  dynamic "workload_autoscaler_profile" {
    for_each = var.workload_autoscaler_profile != null && var.preview_features_enabled ? ["workload_autoscaler_profile"] : []

    content {
      keda_enabled = var.workload_autoscaler_profile["keda_enabled"]
    }
  }

  network_profile {
    network_plugin     = var.network_profile["network_plugin"]
    dns_service_ip     = var.network_profile["dns_service_ip"]
    docker_bridge_cidr = var.network_profile["docker_bridge_cidr"]
    load_balancer_sku  = var.network_profile["load_balancer_sku"]
    network_policy     = var.network_profile["network_policy"]
    outbound_type      = var.network_profile["outbound_type"]
    pod_cidr           = var.network_profile["pod_cidr"]
    service_cidr       = var.network_profile["service_cidr"]

    load_balancer_profile {
      idle_timeout_in_minutes     = var.load_balancer_profile["idle_timeout_in_minutes"]
      managed_outbound_ip_count   = var.load_balancer_profile["managed_outbound_ip_count"]
      managed_outbound_ipv6_count = var.load_balancer_profile["managed_outbound_ipv6_count"]
      outbound_ip_address_ids     = var.load_balancer_profile["outbound_ip_address_ids"]
      outbound_ip_prefix_ids      = var.load_balancer_profile["outbound_ip_prefix_ids"]
      outbound_ports_allocated    = var.load_balancer_profile["outbound_ports_allocated"]
    }
  }

  dynamic "oms_agent" {
    for_each = var.oms_agent_enabled ? ["oms_agent"] : []

    content {
      log_analytics_workspace_id = try(azurerm_log_analytics_workspace.main[0].id, null)
    }
  }

  storage_profile {
    blob_driver_enabled         = var.storage_profile["blob_driver_enabled"]
    disk_driver_enabled         = var.storage_profile["disk_driver_enabled"]
    disk_driver_version         = var.storage_profile["disk_driver_version"]
    file_driver_enabled         = var.storage_profile["file_driver_enabled"]
    snapshot_controller_enabled = var.storage_profile["snapshot_controller_enabled"]
  }

  lifecycle {
    ignore_changes = [
      tags,
      default_node_pool[0].node_count
    ]

    precondition {
      condition     = (var.identity_type == "SystemAssigned") || (var.identity_ids == null ? false : length(var.identity_ids) > 0)
      error_message = "When identity_type `UserAssigned` or `SystemAssigned, UserAssigned` is set, `identity_ids` must be set as well."
    }
    precondition {
      condition     = !(var.microsoft_defender_enabled && !var.create_log_analytics_workspace)
      error_message = "Enabling Microsoft Defender requires that `var.create_log_analytics_workspace` be set to true."
    }
    precondition {
      condition     = !(var.azure_active_directory_role_based_access_control["azure_rbac_enabled"] && !var.role_based_access_control_enabled)
      error_message = "To enable Azure RBAC on the Kubernetes Cluster`, also set `var.role_based_access_control_enabled` to `true`."
    }
    precondition {
      condition     = var.automatic_channel_upgrade != ""
      error_message = "Either disable automatic upgrades, or only specify up to the minor version when using `automatic_channel_upgrade=patch` or don't specify `kubernetes_version` at all when using `automatic_channel_upgrade=stable|rapid|node-image`. With automatic upgrades `orchestrator_version` must be set to `null`."
    }
    precondition {
      condition     = !(var.workload_identity_enabled && !var.preview_features_enabled)
      error_message = "Workload Identity is a Preview feature. To enable Preview features, please set `preview_features_enabled` to `true`. Be aware that Microsoft's Preview features are untested and may never graduate to General Availability."
    }
    precondition {
      condition     = !(!var.oidc_issuer_enabled && var.workload_identity_enabled && !var.preview_features_enabled)
      error_message = "To enable the Preview feature Workload Identity, `oidc_issuer_enabled` must also be set to `true`."
    }
    precondition {
      condition     = !(var.image_cleaner_enabled && !var.preview_features_enabled)
      error_message = "Image Cleaner is a Preview feature. To enable Preview features, please set `preview_features_enabled` to `true`. Be aware that Microsoft's Preview features are untested and may never graduate to General Availability."
    }
    precondition {
      condition     = !(try(var.api_server_access_profile["vnet_integration_enabled"], false) && !var.preview_features_enabled)
      error_message = "API Server VNet Integration is a Preview feature. To enable Preview features, please set `preview_features_enabled` to `true`. Be aware that Microsoft's Preview features are untested and may never graduate to General Availability."
    }
    precondition {
      condition     = !(var.public_network_access_enabled && var.private_cluster_enabled)
      error_message = "Public and Private access cannot be enabled at the same time."
    }
    precondition {
      condition     = !(var.create_custom_private_dns_zone && var.virtual_network_id == null)
      error_message = "When creating a custom Private DNS Zone, a Virtual Network ID must be passed via `virtual_network_id`."
    }
  }
}

resource "azurerm_log_analytics_workspace" "main" {
  count = var.create_log_analytics_workspace ? 1 : 0

  location            = coalesce(var.log_analytics_workspace["location"], local.location)
  name                = var.log_analytics_workspace["name"] == null ? "${var.name}-workspace" : var.log_analytics_workspace["name"]
  resource_group_name = coalesce(var.log_analytics_workspace["resource_group_name"], var.resource_group_name)
  retention_in_days   = var.log_analytics_workspace["retention_in_days"]
  sku                 = var.log_analytics_workspace["sku"]
  tags                = merge(var.log_analytics_workspace["tags"], var.tags)
}

resource "azurerm_log_analytics_solution" "main" {
  count = var.create_log_analytics_solution ? 1 : 0

  location              = coalesce(var.log_analytics_solution["location"], local.location)
  resource_group_name   = try(azurerm_log_analytics_workspace.main[0].resource_group_name, var.log_analytics_solution["resource_group_name"], var.resource_group_name)
  solution_name         = "ContainerInsights"
  workspace_name        = try(azurerm_log_analytics_workspace.main[0].name, null)
  workspace_resource_id = try(azurerm_log_analytics_workspace.main[0].id, null)
  tags                  = merge(var.log_analytics_solution["tags"], var.tags)

  plan {
    product   = "OMSGallery/ContainerInsights"
    publisher = "Microsoft"
  }
}

# Additional node pools
resource "azurerm_kubernetes_cluster_node_pool" "main" {
  for_each = var.node_pools

  name                   = each.key
  kubernetes_cluster_id  = azurerm_kubernetes_cluster.main.id
  vm_size                = each.value.vm_size
  enable_auto_scaling    = each.value.enable_auto_scaling
  enable_host_encryption = each.value.enable_host_encryption
  enable_node_public_ip  = each.value.enable_node_public_ip
  max_pods               = each.value.max_pods
  node_count             = each.value.enable_auto_scaling ? null : coalesce(each.value.node_count, 1)
  min_count              = each.value.enable_auto_scaling ? coalesce(each.value.min_count, 1) : null
  max_count              = each.value.enable_auto_scaling ? coalesce(each.value.max_count, each.value.min_count + 1) : null
  node_labels            = each.value.node_labels
  orchestrator_version   = each.value.orchestrator_version
  os_disk_size_gb        = each.value.os_disk_size_gb
  os_disk_type           = each.value.os_disk_type
  pod_subnet_id          = each.value.pod_subnet_id
  scale_down_mode        = each.value.scale_down_mode
  ultra_ssd_enabled      = each.value.ultra_ssd_enabled
  vnet_subnet_id         = var.default_node_pool["vnet_subnet_id"]
  zones                  = coalesce(each.value.zones, var.default_node_pool["zones"])
  tags                   = merge(var.tags, each.value.tags)

  lifecycle {
    ignore_changes = [
      tags,
      node_count
    ]
  }
}

# Create a Container Registry, if required
resource "azurerm_container_registry" "main" {
  count = var.container_registry_enabled ? 1 : 0

  name                = coalesce(try(var.container_registry["name"], null), replace("${var.name}acr", "[^a-zA-Z0-9]+", ""))
  resource_group_name = var.resource_group_name
  location            = local.location
  sku                 = try(var.container_registry["sku"], "Basic")
  tags                = merge(var.tags, try(var.container_registry["tags"], {}))
}

resource "azurerm_private_endpoint" "acr" {
  count = try(var.container_registry["private_endpoint"], null) != null && try(var.container_registry["sku"], null) == "Premium" ? 1 : 0

  name                = "${azurerm_container_registry.main[0].name}-private-endpoint"
  location            = azurerm_container_registry.main[0].location
  resource_group_name = var.resource_group_name
  subnet_id           = var.container_registry["private_endpoint"]["subnet_id"]
  tags                = merge(var.tags, try(var.container_registry["private_endpoint"]["tags"], {}))

  private_dns_zone_group {
    name                 = "${azurerm_container_registry.main[0].name}-private-dns-zone-group"
    private_dns_zone_ids = var.container_registry["private_endpoint"]["private_dns_zone_ids"]
  }

  private_service_connection {
    name                           = "${azurerm_container_registry.main[0].name}-private-service_connection"
    private_connection_resource_id = azurerm_kubernetes_cluster.main.id
    is_manual_connection           = var.container_registry["private_endpoint"]["is_manual_connection"]
    subresource_names              = ["registry"]
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create a Private Endpoint for the Kubernetes Cluster
resource "azurerm_private_endpoint" "main" {
  for_each = var.private_endpoint != null ? var.private_endpoint : {}

  name                = "${azurerm_kubernetes_cluster.main.name}-private-endpoint"
  location            = azurerm_kubernetes_cluster.main.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value.subnet_id
  tags                = var.tags

  private_dns_zone_group {
    name                 = "${azurerm_kubernetes_cluster.main.name}-private-dns-zone-group"
    private_dns_zone_ids = each.value.private_dns_zone_ids
  }

  private_service_connection {
    name                           = "${azurerm_kubernetes_cluster.main.name}-private-service_connection"
    private_connection_resource_id = azurerm_kubernetes_cluster.main.id
    is_manual_connection           = each.value.is_manual_connection
    subresource_names              = each.value.subresource_names
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create a custom Private DNS Zone, if required
resource "azurerm_private_dns_zone" "main" {
  count = var.create_custom_private_dns_zone ? 1 : 0

  name                = "privatelink.${local.location}.azmk8s.io"
  resource_group_name = var.resource_group_name
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Delay for permissions propagation, or the deployment will fail waiting for permissions
resource "time_sleep" "aks_creation_delay" {
  create_duration = "5m"

  triggers = {
    id = "${azurerm_user_assigned_identity.main.id}${local.time_sleep_dependencies}"
  }
}

locals {
  # Kubernetes Cluster needs to wait for role assignments to be created, or it will error out trying to authenticate before propagation
  time_sleep_dependencies = <<-EOT
    ${try(azurerm_role_assignment.vnet[0].id, null) != null ? "" : ""}
    ${try(azurerm_role_assignment.acr[0].id, null) != null ? "" : ""}
    ${try(azurerm_role_assignment.dns[0].id, null) != null ? "" : ""}
  EOT
}

# Role assignments required to access the ACR and DNS Zone
resource "azurerm_role_assignment" "dns" {
  count = var.create_custom_private_dns_zone ? 1 : 0

  principal_id                     = azurerm_user_assigned_identity.main.principal_id
  role_definition_name             = "Private DNS Zone Contributor"
  scope                            = azurerm_private_dns_zone.main[0].id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "vnet" {
  count = var.create_custom_private_dns_zone ? 1 : 0

  principal_id                     = azurerm_user_assigned_identity.main.principal_id
  role_definition_name             = "Private DNS Zone Contributor"
  scope                            = var.virtual_network_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "acr" {
  count = var.container_registry_enabled ? 1 : 0

  principal_id                     = azurerm_user_assigned_identity.main.principal_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.main[0].id
  skip_service_principal_aad_check = true
}

# Locals
locals {
  location = replace(lower(var.location), " ", "") # Convert verbose locations to lowercase
}