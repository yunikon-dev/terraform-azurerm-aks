# Cluster variables
variable "name" {
  type        = string
  default     = null
  description = "(Optional) The name for the Azure Kubernetes Service resources created in the specified Resource Group."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  default     = null
  description = "(Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created."
}

variable "dns_prefix" {
  type        = string
  description = "(Optional) DNS prefix specified when creating the Managed Kubernetes Cluster. Changing this forces a new resource to be created."
}

variable "create_analytics_workspace" {
  type        = bool
  default     = false
  description = "(Optional) Create a Log Analytics Workspace for Kubernetes."

}

variable "create_analytics_solution" {
  type        = bool
  default     = false
  description = "(Optional) Create a Log Analytics Solution for Kubernetes."
}

variable "role_based_access_control_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created."
}

# Default Node Pool variables
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
    only_critical_addons_enabled = optional(bool, null)
    orchestrator_version         = optional(string)
    os_disk_size_gb              = optional(number, 40)
    os_disk_type                 = optional(string)
    pod_subnet_id                = optional(string)
    scale_down_mode              = optional(string)
    tags                         = optional(map(string), null)
    type                         = optional(string, "VirtualMachineScaleSets")
    ultra_ssd_enabled            = optional(bool, false)
    vnet_subnet_id               = optional(string)
    zones                        = optional(list(number), [1, 2, 3])
  })
  description = "(Required) Default Node Pool variables. Refer to the [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables."
}

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
  default     = {}
  description = "(Optional) Additional Node Pool variables. Refer to the [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) documentation for more information on these variables."
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
  description = "(Optional) Auto scaler variables. Only used when `enable_auto_scaling` is set to `true`. Refer to the [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables."
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
  description = "(Optional) Load balancer variables. Only used when `load_balancer_sku` is set to `standard`. Refer to the [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables."
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
  description = "(Required) Networking variables. Refer to the [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables."
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
  description = "(Optional) Storage variables. Enables support for blobs, disks, file shares and snapshotting. Refer to the [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables."
}

variable "azure_active_directory_role_based_access_control_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Enables support for Azure Active Directory RBAC."
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
  description = "(Optional) Azure Active Directory RBAC variables. When `managed` is set to `true`, `admin_group_object_ids` must be given the `object_id`s of an Azure AD Group and `azure_rbac_enabled` can be specified. Refer to the [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables."
}

variable "ingress_application_gateway" {
  type = object({
    gateway_id   = optional(string)
    gateway_name = optional(string)
    subnet_cidr  = optional(string)
    subnet_id    = optional(string)
  })
  default     = null
  description = "(Optional) Application Gateway Ingress Controller variables. Create an Application Gateway and pass the required variables to this module. Refer to the [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables."
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
  description = "(Optional) Set the configurable options for the Key Vault Secrets provider. Refer to the [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables."
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
  description = "(Optional) Sets the user profile options for Linux OS node pools."
}

variable "create_log_analytics_workspace" {
  type        = bool
  default     = false
  description = "(Optional) Creates a Log Analytics Workspace dedicated to the Kubernetes Cluster."
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
  description = "(Optional) Sets the variables for the Log Analytics Workspace for this cluster. Refer to the [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables."
}

variable "create_log_analytics_solution" {
  type        = bool
  default     = false
  description = "(Optional) Creates a Log Analytics Solution dedicated to the Kubernetes Cluster."
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
  description = "(Optional) Creates a Log Analytics Solution dedicated to the cluster. Requires `create_log_analytics_workspace` to be set to `true`."
}

#
variable "automatic_channel_upgrade" {
  type        = string
  default     = null
  description = "(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image, and stable. By default, automatic upgrades are turned off. Note that you cannot use the patch upgrade channel and still specify the patch version using kubernetes_version. See the documentation for more information."

  validation {
    condition = var.automatic_channel_upgrade == null ? true : contains([
      "patch", "stable", "rapid", "node-image"
    ], var.automatic_channel_upgrade)
    error_message = "`automatic_channel_upgrade`'s possible values are `patch`, `stable`, `rapid` or `node-image`."
  }
}

variable "azure_policy_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should the Azure Policy Add-On be enabled? For more details, please visit [Understand Azure Policy for Azure Kubernetes Service](https://docs.microsoft.com/en-ie/azure/governance/policy/concepts/rego-for-aks)."

}

variable "disk_encryption_set_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. More information [can be found in the documentation](https://docs.microsoft.com/azure/aks/azure-disk-customer-managed-keys). Changing this forces a new resource to be created."

}

variable "http_application_routing_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should HTTP Application Routing be enabled?"
}

variable "identity_ids" {
  type        = list(string)
  default     = []
  description = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this AKS Cluster."

}

variable "identity_type" {
  type        = string
  default     = "SystemAssigned"
  description = "(Optional) The type of identity used for the managed cluster. Conflict with `client_id` and `client_secret`. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`(to enable both). If `UserAssigned` or `SystemAssigned, UserAssigned` is set, an `identity_ids` must be set as well."

  validation {
    condition     = var.identity_type == "SystemAssigned" || var.identity_type == "UserAssigned" || var.identity_type == "SystemAssigned, UserAssigned"
    error_message = "`identity_type`'s possible values are `SystemAssigned`, `UserAssigned` or `SystemAssigned, UserAssigned`(to enable both)."
  }
}

variable "kubernetes_version" {
  type        = string
  default     = null
  description = "(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). AKS does not require an exact patch version to be specified, minor version aliases such as `1.22` are also supported. The minor version's latest GA patch is automatically chosen in that case. More details can be found in [the documentation](https://docs.microsoft.com/en-us/azure/aks/supported-kubernetes-versions?tabs=azure-cli#alias-minor-version)."
}

variable "local_account_disabled" {
  type        = bool
  default     = true
  description = "(Optional) If true local accounts will be disabled. See [the documentation](https://docs.microsoft.com/azure/aks/managed-aad#disable-local-accounts) for more information."

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
  default     = null
  description = "(Preview, Optional) The desired maintenance windows for the cluster. Currently, performing maintenance operations are considered best-effort only and are not guaranteed to occur within a specified window. Refer to the [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables."

}

variable "network_policy" {
  type        = string
  default     = null
  description = " (Optional) Sets up Network Policy to be used with Azure CNI. Network Policy allows control of the traffic flow between pods. Currently supported values are `calico` and `azure`. Changing this forces a new resource to be created."

}

variable "node_resource_group" {
  type        = string
  default     = null
  description = "(Optional) The auto-generated Resource Group which contains the resources for the Kubernetes Cluster. Changing this forces a new resource to be created."

}

variable "oidc_issuer_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Enable or Disable the OIDC issuer URL. Defaults to false."

}

variable "open_service_mesh_enabled" {
  type        = bool
  default     = false
  nullable    = false
  description = "(Optional) Enables Open Service Mesh. For more details, please visit [Open Service Mesh for AKS](https://docs.microsoft.com/azure/aks/open-service-mesh-about)."

}

variable "private_cluster_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to `false`. Changing this forces a new resource to be created."

}

variable "private_cluster_public_fqdn_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Specifies whether a Public FQDN for this Private Kubernetes Cluster should be added. Defaults to `false`."
}

variable "private_dns_zone_id" {
  type        = string
  default     = null
  description = "(Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, `System` to have AKS manage this or `None`. In case of `None` you will need to bring your own DNS server and set up resolving, otherwise, the cluster will have issues after provisioning. Changing this forces a new resource to be created."

}

variable "sku_tier" {
  type        = string
  default     = "Free"
  description = "(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are `Free` and `Paid` (which includes the Uptime SLA). Defaults to `Free`."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) A mapping of tags to assign to the resource."

}

variable "workload_identity_enabled" {
  type        = bool
  default     = false
  description = "(Optional, Preview), Enable or disable Workload Identity. Defaults to `false`."

}

variable "oms_agent_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Enables the OMS Agent for the Kubernetes Cluster. Defaults to `false`."
}

variable "microsoft_defender_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Enables Microsoft Defender for the Kubernetes Cluster. Defaults to `false`."
}

variable "container_registry_enabled" {
  type    = bool
  default = false
}

variable "container_registry" {
  type = object({
    name = string
    sku  = optional(string, "Standard")
    tags = optional(map(string))
    private_endpoint = optional(object({
      private_dns_zone_ids = optional(list(string), [])
      is_manual_connection = optional(bool, false)
      tags                 = optional(bool, null)
    }))
  })
  default     = null
  description = "(Optional) Container Registry variables. When defined, creates a Container Registry and a role assignment that grants the Kubernetes Cluster `AcrPull` permissions. Refer to the [azurem_container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) documentation for more information on these variables."
}

variable "azuread_groups" {
  type        = list(any)
  default     = []
  description = "List of Azure AD Group names that will be assigned Administrator permissions on the Kubernetes Cluster."
}

variable "preview_features_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Enables Preview features on the Kubernetes Cluster. Warning: Do not enable this in production."
}

# Preview features
variable "image_cleaner_enabled" {
  type        = bool
  default     = false
  description = "(Optional, Preview) Enables the Image Cleaner."
}

variable "image_cleaner_interval_hours" {
  type        = number
  default     = 48
  description = "(Optional, Preview) Controls the Image Cleaner interval in hours."
}

variable "workload_autoscaler_profile" {
  type = object({
    keda_enabled = optional(bool, true)
  })
  default     = null
  description = "(Optional, Preview) Controls the Workload Autoscaler. Refer to [the documentation](https://learn.microsoft.com/en-us/azure/aks/workload-identity-deploy-cluster#register-the-enableworkloadidentitypreview-feature-flag) for more information."
}

variable "private_endpoint" {
  type = map(object({
    subnet_id            = optional(string)
    private_dns_zone_ids = optional(list(string), [])
    is_manual_connection = optional(bool, false)
    subresource_names    = optional(list(string), ["management"])
  }))
  default     = {}
  description = "(Optional) Private Endpoint for the Kubernetes Cluster."
}

variable "virtual_network_id" {
  type        = string
  default     = null
  description = "(Optional) ID of the Virtual Network to link the custom Private DNS Zone with."
}

variable "create_custom_private_dns_zone" {
  type        = bool
  default     = false
  description = "(Optional) Creates a custom Private DNS Zone that is not managed by the Kubernetes Cluster."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Enables public access to the Kubernetes Cluster API."
}

variable "api_server_access_profile" {
  type = object({
    authorized_ip_ranges     = optional(list(string))
    subnet_id                = optional(string)
    vnet_integration_enabled = optional(bool, false)
  })
  default     = null
  description = "(Optional) Controls access options of the API server. `vnet_integration_enabled` is currently in Preview. Be aware that Microsoft's Preview features are untested and may never graduate to General Availability."
}