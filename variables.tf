# Cluster variables
variable "dns_prefix" {
  type        = string
  description = "(Optional) The DNS prefix for the Azure AKS Cluster."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group to be used."
}

variable "admin_username" {
  type        = string
  description = "(Optional) The username of the local administrator to be created on the AKS Cluster. Set this variable to `null` to turn off the cluster's `linux_profile`. Changing this forces a new resource to be created."
  default     = null
}

variable "create_analytics_workspace" {
  type        = bool
  description = "Create a Log Analytics Workspace for Kubernetes."
  default     = false
}

variable "create_analytics_solution" {
  type        = bool
  description = "Create a Log Analytics Solution for Kubernetes."
  default     = false
}

variable "role_based_access_control_enabled" {
  type    = bool
  default = true
}

# New Default Node Pool variables
variable "node_pools" {
  type = map(object({
    vm_size                      = optional(string, "Standard_F4s")
    enable_auto_scaling          = optional(bool, true)
    enable_host_encryption       = optional(bool)
    enable_node_public_ip        = optional(string)
    max_count                    = optional(number)
    max_pods                     = optional(number, 50)
    min_count                    = optional(number)
    node_count                   = optional(number)
    node_labels                  = optional(map(string))
    node_taints                  = optional(list(string), [])
    only_critical_addons_enabled = optional(bool)
    orchestrator_version         = optional(string)
    os_disk_size_gb              = optional(number)
    os_disk_type                 = optional(string)
    pod_subnet_id                = optional(string)
    scale_down_mode              = optional(string)
    tags                         = optional(map(string), null)
    type                         = optional(string)
    ultra_ssd_enabled            = optional(bool)
    vnet_subnet_id               = optional(string)
    zones                        = optional(list(number))
  }))
  description = "Node pools"
}

variable "default_node_pool" {
  type = object({
    name                         = optional(string, "default")
    vm_size                      = optional(string, "Standard_B2s")
    enable_auto_scaling          = optional(bool, true)
    enable_host_encryption       = optional(bool)
    enable_node_public_ip        = optional(string)
    max_count                    = optional(number)
    max_pods                     = optional(number, 50)
    min_count                    = optional(number, 1)
    node_count                   = optional(number, 1)
    node_labels                  = optional(map(string))
    node_taints                  = optional(list(string), null)
    only_critical_addons_enabled = optional(bool)
    orchestrator_version         = optional(string)
    os_disk_size_gb              = optional(number)
    os_disk_type                 = optional(string)
    pod_subnet_id                = optional(string)
    scale_down_mode              = optional(string)
    tags                         = optional(map(string), null)
    type                         = optional(string, "VirtualMachineScaleSets")
    ultra_ssd_enabled            = optional(bool)
    vnet_subnet_id               = optional(string)
    zones                        = optional(list(number), [1, 2, 3])
  })
  description = "Default Node Pool variables"
}

variable "api_server_authorized_ip_ranges" {
  type        = set(string)
  description = "(Optional) The IP ranges to allow for incoming traffic to the server nodes."
  default     = null
}

variable "auto_scaler_profile" {
  type = object({
    balance_similar_node_groups      = optional(bool)
    empty_bulk_delete_max            = optional(number)
    expander                         = optional(string)
    max_graceful_termination_sec     = optional(number)
    max_node_provisioning_time       = optional(string)
    max_unready_nodes                = optional(number)
    max_unready_percentage           = optional(number)
    new_pod_scale_up_delay           = optional(string)
    scale_down_delay_after_add       = optional(string)
    scale_down_delay_after_delete    = optional(string)
    scale_down_delay_after_failure   = optional(string)
    scale_down_unneeded              = optional(string)
    scale_down_unready               = optional(string)
    scale_down_utilization_threshold = optional(string)
    scan_interval                    = optional(string)
    skip_nodes_with_local_storage    = optional(bool)
    skip_nodes_with_system_pods      = optional(bool)
  })
  default = {
    balance_similar_node_groups      = null
    empty_bulk_delete_max            = null
    expander                         = null
    max_graceful_termination_sec     = null
    max_node_provisioning_time       = null
    max_unready_nodes                = null
    max_unready_percentage           = null
    new_pod_scale_up_delay           = null
    scale_down_delay_after_add       = null
    scale_down_delay_after_delete    = null
    scale_down_delay_after_failure   = null
    scale_down_unneeded              = null
    scale_down_unready               = null
    scale_down_utilization_threshold = null
    scan_interval                    = null
    skip_nodes_with_local_storage    = null
    skip_nodes_with_system_pods      = null
  }
  description = "List of auto scaler profiles."
}

variable "load_balancer_profile" {
  type = object({
    idle_timeout_in_minutes     = optional(number)
    managed_outbound_ip_count   = optional(number)
    managed_outbound_ipv6_count = optional(number)
    outbound_ip_address_ids     = optional(list(string))
    outbound_ip_prefix_ids      = optional(list(string))
    outbound_ports_allocated    = optional(number)
  })
  default = {
    idle_timeout_in_minutes     = null
    managed_outbound_ip_count   = null
    managed_outbound_ipv6_count = null
    outbound_ip_address_ids     = null
    outbound_ip_prefix_ids      = null
    outbound_ports_allocated    = null
  }
}

variable "network_profile" {
  type = object({
    network_plugin     = optional(string, "azure")
    dns_service_ip     = optional(string)
    docker_bridge_cidr = optional(string)
    load_balancer_sku  = optional(string)
    network_policy     = optional(string)
    outbound_type      = optional(string)
    pod_cidr           = optional(string)
    service_cidr       = optional(string)
  })
  default = {
    network_plugin     = "azure"
    dns_service_ip     = null
    docker_bridge_cidr = null
    load_balancer_sku  = null
    network_plugin     = null
    network_policy     = null
    outbound_type      = null
    pod_cidr           = null
    service_cidr       = null
  }
}

variable "storage_profile" {
  type = object({
    blob_driver_enabled         = bool
    disk_driver_enabled         = bool
    disk_driver_version         = string
    file_driver_enabled         = bool
    snapshot_controller_enabled = bool
  })
  default = {
    blob_driver_enabled         = true
    disk_driver_enabled         = true
    disk_driver_version         = "v1"
    file_driver_enabled         = true
    snapshot_controller_enabled = true
  }
}

variable "enable_azure_active_directory_role_based_access_control" {
  type    = bool
  default = false
}

variable "azure_active_directory_role_based_access_control" {
  type = object({
    managed                = optional(bool)
    tenant_id              = optional(string)
    admin_group_object_ids = optional(list(string))
    azure_rbac_enabled     = optional(bool)
    client_app_id          = optional(string)
    server_app_id          = optional(string)
    server_app_secret      = optional(string)
  })
  default = {
    admin_group_object_ids = null
    azure_rbac_enabled     = null
    client_app_id          = null
    managed                = null
    server_app_id          = null
    server_app_secret      = null
    tenant_id              = null
  }
}

variable "enable_ingress_application_gateway" {
  type        = bool
  description = "Whether to deploy an Application Gateway Ingress Controller to this AKS Cluster."
  default     = false
  nullable    = false
}

variable "ingress_application_gateway" {
  type = object({
    gateway_id   = optional(string)
    gateway_name = optional(string)
    subnet_cidr  = optional(string)
    subnet_id    = optional(string)
  })
  default = {
    gateway_id   = null
    gateway_name = null
    subnet_cidr  = null
    subnet_id    = null
  }
}

variable "enable_key_vault_secrets_provider" {
  type    = bool
  default = true
}

variable "key_vault_secrets_provider" {
  type = object({
    secret_rotation_enabled  = optional(bool)
    secret_rotation_interval = optional(string)
  })
  default = {
    secret_rotation_enabled  = true
    secret_rotation_interval = "5m"
  }
}

variable "linux_profile" {
  type = object({
    admin_username = optional(string)
    key_data       = optional(string)
  })
  default = {
    admin_username = "azureadmin"
    key_data       = null
  }
}

variable "create_log_analytics_workspace" {
  type        = bool
  default     = false
  description = "value"
}

variable "log_analytics_workspace" {
  type = object({
    location            = optional(string, null)
    name                = optional(string, null)
    resource_group_name = optional(string, null)
    retention_in_days   = optional(number, null)
    sku                 = optional(string, null)
    tags                = optional(map(string), null)
  })
  default = {
    location            = null
    name                = null
    resource_group_name = null
    retention_in_days   = null
    sku                 = null
    tags                = null
  }
  description = "value"
}

variable "create_log_analytics_solution" {
  type        = bool
  default     = false
  description = "value"
}

variable "log_analytics_solution" {
  type = object({
    location = optional(string, null)
    tags     = optional(map(string), null)
  })
  default = {
    location = null
    tags     = null
  }
  description = "value"
}

#
variable "automatic_channel_upgrade" {
  type        = string
  default     = null
  description = "(Optional) The upgrade channel for this AKS Cluster. Possible values are patch, rapid, node-image, and stable. By default, automatic upgrades are turned off. Note that you cannot use the patch upgrade channel and still specify the patch version using kubernetes_version. See the documentation for more information."
  validation {
    condition = var.automatic_channel_upgrade == null ? true : contains([
      "patch", "stable", "rapid", "node-image"
    ], var.automatic_channel_upgrade)
    error_message = "`automatic_channel_upgrade`'s possible values are `patch`, `stable`, `rapid` or `node-image`."
  }
}

variable "azure_policy_enabled" {
  type        = bool
  description = "(Optional) Enables the Azure Policy Add-on."
  default     = false
}

variable "cluster_name" {
  type        = string
  description = "(Optional) The name for the Azure Kubernetes Service resources created in the specified Resource Group."
  default     = null
}

variable "disk_encryption_set_id" {
  type        = string
  description = "(Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. More information [can be found in the documentation](https://docs.microsoft.com/azure/aks/azure-disk-customer-managed-keys). Changing this forces a new resource to be created."
  default     = null
}

variable "http_application_routing_enabled" {
  type        = bool
  description = "(Optional) Enable HTTP Application Routing Addon (forces recreation). This setting is not recommended for non-development clusters."
  default     = false
}

variable "identity_ids" {
  type        = list(string)
  description = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this AKS Cluster."
  default     = []
}

variable "identity_type" {
  type        = string
  description = "(Optional) The type of identity used for the managed cluster. Conflict with `client_id` and `client_secret`. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`(to enable both). If `UserAssigned` or `SystemAssigned, UserAssigned` is set, an `identity_ids` must be set as well."
  default     = "SystemAssigned"

  validation {
    condition     = var.identity_type == "SystemAssigned" || var.identity_type == "UserAssigned" || var.identity_type == "SystemAssigned, UserAssigned"
    error_message = "`identity_type`'s possible values are `SystemAssigned`, `UserAssigned` or `SystemAssigned, UserAssigned`(to enable both)."
  }
}

variable "kubernetes_version" {
  type        = string
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region"
  default     = null
}

variable "local_account_disabled" {
  type        = bool
  description = "(Optional) - If set to `true`, local accounts will be disabled. Defaults to `false`. See [the documentation](https://docs.microsoft.com/azure/aks/managed-aad#disable-local-accounts) for more information."
  default     = true
}

variable "location" {
  type        = string
  description = "Azure region of the AKS Cluster, if not defined, this setting will be inherited from the Resource Group."
  default     = null
}

variable "maintenance_window" {
  type = object({
    allowed = list(object({
      day   = string
      hours = set(number)
    })),
    not_allowed = list(object({
      end   = string
      start = string
    })),
  })
  description = "(Preview, Optional) The desired maintenance windows for the cluster. Currently, performing maintenance operations are considered best-effort only and are not guaranteed to occur within a specified window."
  default     = null
}

variable "network_policy" {
  type        = string
  description = " (Optional) Sets up Network Policy to be used with Azure CNI. Network Policy allows control of the traffic flow between pods. Currently supported values are `calico` and `azure`. Changing this forces a new resource to be created."
  default     = null
}

variable "node_resource_group" {
  type        = string
  description = "The auto-generated Resource Group which contains the resources for the AKS Cluster. Changing this forces a new resource to be created."
  default     = null
}

variable "oidc_issuer_enabled" {
  description = "Enable or Disable the OIDC issuer URL. Defaults to false."
  type        = bool
  default     = false
}

variable "open_service_mesh_enabled" {
  type        = bool
  description = "(Optional) Enables Open Service Mesh. For more details, please visit [Open Service Mesh for AKS](https://docs.microsoft.com/azure/aks/open-service-mesh-about)."
  default     = false
  nullable    = false
}

variable "private_cluster_enabled" {
  type        = bool
  description = "If set to true, cluster API server will be exposed only on internal IP address and available only in cluster vnet."
  default     = true
}

variable "private_cluster_public_fqdn_enabled" {
  type        = bool
  description = "(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to `false`."
  default     = true
}

variable "private_dns_zone_id" {
  type        = string
  description = "(Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, `System` to have AKS manage this or `None`. In case of `None` you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created."
  default     = null
}

variable "public_ssh_key" {
  type        = string
  description = "A custom ssh key to control access to the AKS Cluster. Changing this forces a new resource to be created."
  default     = ""
}

variable "sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this AKS Cluster. Possible values are `Free` and `Paid`"
  default     = "Free"
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the AKS Cluster resources"
  default     = null
}

variable "workload_identity_enabled" {
  description = "(Optional, Preview), Enable or disable Workload Identity. Defaults to `false`."
  type        = bool
  default     = false
}

variable "enable_oms_agent" {
  type    = bool
  default = false
}

variable "enable_microsoft_defender" {
  type    = bool
  default = false
}

variable "create_node_resource_group" {
  type    = bool
  default = true

}

variable "create_container_registry" {
  type    = bool
  default = true
}

variable "container_registry" {
  type = object({
    name = string
    sku  = string
    tags = optional(map(string))
  })
  default = {
    name = null
    sku  = "Standard"
    tags = null
  }
}

variable "azuread_groups" {
  type    = list(any)
  default = []
}

variable "enable_preview_features" {
  type    = bool
  default = false
}

variable "image_cleaner_enabled" {
  type    = bool
  default = false
}

variable "image_cleaner_interval_hours" {
  type    = number
  default = 48
}

# Preview feature: Workload Autoscaler
variable "enable_workload_autoscaler_profile" {
  type    = bool
  default = false
}

variable "workload_autoscaler_profile" {
  type = object({
    keda_enabled = optional(bool, true)
  })
  default = {
    keda_enabled = null
  }
}

variable "azurerm_private_endpoint" {
  type = map(object({
    subnet_id            = optional(string)
    private_dns_zone_ids = optional(list(string), [])
    is_manual_connection = optional(bool, false)
    subresource_names    = optional(list(string), ["aks"])
  }))
  default = {}
}

variable "virtual_network_id" {
  type    = string
  default = null
}

variable "create_custom_private_dns_zone" {
  type    = bool
  default = false
}