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

variable "automatic_channel_upgrade_check" {
  type        = bool
  description = "Automatic channel upgrade check"
  default     = false
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

variable "cluster_log_analytics_workspace_name" {
  type        = string
  description = "Name for the Log Analytics Workspace for Kubernetes."
  default     = null
}

# Default Node Pool variables
variable "default_node_pool_availability_zones" {
  type        = list(string)
  description = "(Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created."
  default     = [1, 2, 3]
}

variable "default_node_pool_enable_auto_scaling" {
  type        = bool
  description = "Enable auto scaling for the default node pool."
  default     = true
}

variable "default_node_pool_node_count" {
  type        = number
  description = "The number of nodes that should exist in the Node Pool. Please set `node_count` to `null` while `enable_auto_scaling` is `true` to avoid possible `node_count` changes."
  default     = 1
}

variable "default_node_pool_node_labels" {
  type        = map(string)
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created."
  default     = {}
}

variable "default_node_pool_max_count" {
  type        = number
  description = "(Optional) The maximum number of nodes in the default node pool."
  default     = null
}

variable "default_node_pool_max_pods" {
  type        = number
  description = "(Optional) The maximum number of pods that can run on each node. Changing this forces a new node pool to be created manually."
  default     = 110
}

variable "default_node_pool_min_count" {
  type        = number
  description = "(Optional) Minimum number of nodes in the default node pool."
  default     = null
}

variable "default_node_pool_name" {
  type        = string
  description = "The default node pool name."
  default     = "default"
  nullable    = false
}

variable "default_node_pool_size" {
  type        = string
  description = "The default Virtual Machine Scale Set size for the default node pool."
  default     = "Standard_F4s_v2"
}

variable "default_node_pool_tags" {
  type        = map(string)
  description = "(Optional) A map of tags to assign to the default node pool."
  default     = {}
}

variable "default_node_pool_orchestrator_version" {
  type        = string
  description = "Specify which Kubernetes release to use for the orchestration layer. The default used is the latest Kubernetes version available in the region"
  default     = null
}

variable "default_node_pool_os_disk_size_gb" {
  type        = number
  description = "Disk size of nodes in GBs."
  default     = 40
}

variable "default_node_pool_os_disk_type" {
  type        = string
  description = "The type of disk which should be used for the Operating System. Possible values are `Ephemeral` and `Managed`. Defaults to `Managed`. Changing this forces a new resource to be created."
  default     = "Managed"
  nullable    = false
}

variable "default_node_pool_pod_subnet_id" {
  type        = string
  description = "(Optional) The ID of the Subnet where the pods in the default node pool should exist. Changing this forces a new resource to be created."
  default     = null
}

###
variable "api_server_authorized_ip_ranges" {
  type        = set(string)
  description = "(Optional) The IP ranges to allow for incoming traffic to the server nodes."
  default     = null
}

# Auto Scaler Profile settings
variable "auto_scaler_profile_balance_similar_node_groups" {
  description = "(Optional) Detect similar node groups and balance the number of nodes between them. Defaults to `false`."
  type        = bool
  default     = false
}

variable "auto_scaler_profile_empty_bulk_delete_max" {
  description = "Maximum number of empty nodes that can be deleted at the same time. Defaults to `10`."
  type        = number
  default     = 10
}

variable "auto_scaler_profile_enabled" {
  type        = bool
  description = "Enable configuring the auto-scaler profile."
  default     = false
  nullable    = false
}

variable "auto_scaler_profile_expander" {
  description = "Expander to use. Possible values are `least-waste`, `priority`, `most-pods` and `random`. Defaults to `random`."
  type        = string
  default     = "random"
  validation {
    condition     = contains(["least-waste", "most-pods", "priority", "random"], var.auto_scaler_profile_expander)
    error_message = "Must be either `least-waste`, `most-pods`, `priority` or `random`."
  }
}

variable "auto_scaler_profile_max_graceful_termination_sec" {
  description = "Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node. Defaults to `600`."
  type        = number
  default     = 600
}

variable "auto_scaler_profile_max_node_provisioning_time" {
  description = "Maximum time the autoscaler waits for a node to be provisioned. Defaults to `15m`."
  type        = string
  default     = "15m"
}

variable "auto_scaler_profile_max_unready_nodes" {
  description = "Maximum Number of allowed unready nodes. Defaults to `3`."
  type        = number
  default     = 3
}

variable "auto_scaler_profile_max_unready_percentage" {
  description = "Maximum percentage of unready nodes the cluster autoscaler will stop if the percentage is exceeded. Defaults to `45`."
  type        = number
  default     = 45
}

variable "auto_scaler_profile_new_pod_scale_up_delay" {
  description = "For scenarios such as burst or batch scale, where you do not want the Cluster Autoscaler to act before the Kubernetes scheduler can schedule all the pods, you can tell the CA to ignore unscheduled pods before they reach a certain age. The default is 10s."
  type        = string
  default     = "10s"
}

variable "auto_scaler_profile_scale_down_delay_after_add" {
  description = "How long after the scale up of AKS nodes the scale down evaluation resumes. Defaults to `10m`."
  type        = string
  default     = "10m"
}

variable "auto_scaler_profile_scale_down_delay_after_delete" {
  description = "How long after node deletion that scale down evaluation resumes. Defaults to `10s`."
  type        = string
  default     = "10s"
}

variable "auto_scaler_profile_scale_down_delay_after_failure" {
  description = "How long after scale down failure that scale down evaluation resumes. Defaults to `3m`."
  type        = string
  default     = "3m"
}

variable "auto_scaler_profile_scale_down_unneeded" {
  description = "How long a node should be unneeded before it is eligible for scale down. Defaults to `10m`."
  type        = string
  default     = "10m"
}

variable "auto_scaler_profile_scale_down_unready" {
  description = "How long an unready node should be unneeded before it is eligible for scale down. Defaults to `20m`."
  type        = string
  default     = "20m"
}

variable "auto_scaler_profile_scale_down_utilization_threshold" {
  description = "Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down. Defaults to `0.5`."
  type        = string
  default     = "0.5"
}

variable "auto_scaler_profile_scan_interval" {
  description = "How often the AKS Cluster should be re-evaluated for scale up/down. Defaults to `10s`."
  type        = string
  default     = "10s"
}

variable "auto_scaler_profile_skip_nodes_with_local_storage" {
  description = "If `true` cluster autoscaler will never delete nodes with pods with local storage, for example, EmptyDir or HostPath. Defaults to `true`."
  type        = bool
  default     = true
}

variable "auto_scaler_profile_skip_nodes_with_system_pods" {
  description = "If `true` cluster autoscaler will never delete nodes with pods from kube-system (except for DaemonSet or mirror pods). Defaults to `true`."
  type        = bool
  default     = true
}

###
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

variable "client_id" {
  type        = string
  description = "(Optional) The Client ID (Application ID) for the Service Principal used for AKS deployment"
  default     = ""
  nullable    = false
}

variable "client_secret" {
  type        = string
  description = "(Optional) The Client Secret (password) for the Service Principal used for the AKS deployment"
  default     = ""
  nullable    = false
}

variable "cluster_log_analytics_workspace_name" {
  type        = string
  description = "(Optional) The name of the Analytics Workspace."
  default     = null
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

variable "enable_host_encryption" {
  type        = bool
  description = "Enable Host Encryption for default node pool. Encryption at host feature [must be enabled on the Subscription](https://docs.microsoft.com/azure/virtual-machines/linux/disks-enable-host-based-encryption-cli)"
  default     = false
}

variable "enable_node_public_ip" {
  type        = bool
  description = "(Optional) Nodes in the default node pool will have a Public IP Address if this option is set to true. Defaults to `false`."
  default     = false
}

variable "http_application_routing_enabled" {
  type        = bool
  description = "(Optional) Enable HTTP Application Routing Addon (forces recreation). This setting is not recommended for non-development clusters."
  default     = false
}

variable "identity_ids" {
  type        = list(string)
  description = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this AKS Cluster."
  default     = null
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

variable "ingress_application_gateway_enabled" {
  type        = bool
  description = "Whether to deploy an Application Gateway Ingress Controller to this AKS Cluster?"
  default     = false
  nullable    = false
}

variable "ingress_application_gateway_id" {
  type        = string
  description = "The ID of the Application Gateway to integrate with the Ingress Controller of this AKS Cluster."
  default     = null
}

variable "ingress_application_gateway_name" {
  type        = string
  description = "The name of the Application Gateway to be used or created in the node pool Resource Group, which in turn will be integrated with the Ingress Controller of this AKS Cluster."
  default     = null
}

variable "ingress_application_gateway_subnet_cidr" {
  type        = string
  description = "The subnet CIDR to be used to create an Application Gateway, which will be integrated with the Ingress Controller of this AKS Cluster."
  default     = null
}

variable "ingress_application_gateway_subnet_id" {
  type        = string
  description = "The ID of the subnet on which to create an Application Gateway, which will be integrated with the Ingress Controller in an AKS Cluster."
  default     = null
}

variable "key_vault_secrets_provider_enabled" {
  type        = bool
  description = "(Optional) Enables the use of the Azure Key Vault Provider for the Secrets Store CSI Driver in this AKS Cluster. For more information, see: [Use the Azure Key Vault Provider for Secrets Store CSI Driver in an AKS Cluster](https://docs.microsoft.com/en-us/azure/aks/csi-secrets-store-driver)."
  default     = false
  nullable    = false
}

variable "kubernetes_version" {
  type        = string
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region"
  default     = null
}

variable "load_balancer_profile_enabled" {
  type        = bool
  description = "(Optional) Enable a load_balancer_profile block. This can only be used when load_balancer_sku is set to `standard`."
  default     = false
  nullable    = false
}

variable "load_balancer_profile_idle_timeout_in_minutes" {
  type        = number
  description = "(Optional) Desired outbound flow idle timeout in minutes for the cluster load balancer. Must be between `4` and `120`. Defaults to `30`."
  default     = 30
}

variable "load_balancer_profile_managed_outbound_ip_count" {
  type        = number
  description = "(Optional) Count of desired managed outbound IPs for the cluster load balancer. Must be between `1` and `100`."
  default     = null
}

variable "load_balancer_profile_managed_outbound_ipv6_count" {
  type        = number
  description = "(Optional) The desired number of IPv6 outbound IPs created and managed by Azure for the cluster load balancer. Must be in the range of `1` to `100`. The default value is `0` for single-stack and `1` for dual-stack. Note: managed_outbound_ipv6_count requires dual-stack networking. To enable dual-stack networking the Preview Feature Microsoft.ContainerService/AKS-EnableDualStack needs to be enabled and the Resource Provider re-registered, [see the documentation for more information](https://learn.microsoft.com/en-us/azure/aks/configure-kubenet-dual-stack?tabs=azure-cli%2Ckubectl#register-the-aks-enabledualstack-preview-feature)."
  default     = null
}

variable "load_balancer_profile_outbound_ip_address_ids" {
  type        = set(string)
  description = "(Optional) The ID of the Public IP Addresses which should be used for outbound communication for the cluster load balancer."
  default     = null
}

variable "load_balancer_profile_outbound_ip_prefix_ids" {
  type        = set(string)
  description = "(Optional) The ID of the outbound Public IP Address Prefixes which should be used for the cluster load balancer."
  default     = null
}

variable "load_balancer_profile_outbound_ports_allocated" {
  type        = number
  description = "(Optional) Number of desired SNAT port for each VM in the clusters load balancer. Must be between `0` and `64000` inclusive. Defaults to `0`"
  default     = 0
}

variable "load_balancer_sku" {
  type        = string
  description = "(Optional) Specifies the SKU of the Load Balancer used for this AKS Cluster. Possible values are `basic` and `standard`. Defaults to `standard`. Changing this forces a new AKS Cluster to be created."
  default     = "standard"

  validation {
    condition     = contains(["basic", "standard"], var.load_balancer_sku)
    error_message = "Possible values are `basic` and `standard`."
  }
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

variable "log_analytics_solution_id" {
  type        = string
  description = "(Optional) Existing `azurerm_log_analytics_solution` resource ID. Providing this ID disables creation of a new `azurerm_log_analytics_solution`."
  default     = null
}

variable "log_analytics_workspace" {
  type = object({
    id   = string
    name = string
  })
  description = "(Optional) Existing `azurerm_log_analytics_workspace` to attach to the `azurerm_log_analytics_solution`. Providing this configuration disables creation of a new `azurerm_log_analytics_workspace`."
  default     = null
}

variable "log_analytics_workspace_enabled" {
  type        = bool
  description = "(Optional) Enables the integration of `azurerm_log_analytics_workspace` and `azurerm_log_analytics_solution`. See [Enable Container insights](https://docs.microsoft.com/en-us/azure/azure-monitor/containers/container-insights-onboard) for more information."
  default     = false
  nullable    = false
}

variable "log_analytics_workspace_resource_group_name" {
  type        = string
  description = "(Optional) Resource Group name to create the `azurerm_log_analytics_solution` in."
  default     = null
}

variable "log_analytics_workspace_sku" {
  type        = string
  description = "(Optional) The SKU of the Log Analytics Workspace. For new Subscriptions the SKU should be set to `PerGB2018`."
  default     = "PerGB2018"
}

variable "log_retention_in_days" {
  type        = number
  description = "(Optional) The retention period for the Log Analytics Workspace logs defined in days."
  default     = 30
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

variable "microsoft_defender_enabled" {
  type        = bool
  description = "(Optional) Is Microsoft Defender on the cluster enabled? Requires `var.log_analytics_workspace_enabled` to be `true` to set this variable to `true`."
  default     = false
  nullable    = false
}

variable "net_profile_dns_service_ip" {
  type        = string
  description = "(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created."
  default     = null
}

variable "net_profile_docker_bridge_cidr" {
  type        = string
  description = "(Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created."
  default     = null
}

variable "net_profile_outbound_type" {
  type        = string
  description = "(Optional) The outbound (egress) routing method which should be used for this AKS Cluster. Possible values are `loadBalancer` and `userDefinedRouting`. Defaults to `loadBalancer`."
  default     = "loadBalancer"
}

variable "net_profile_pod_cidr" {
  type        = string
  description = "(Optional) The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to `kubenet`. Changing this forces a new resource to be created."
  default     = null
}

variable "net_profile_service_cidr" {
  type        = string
  description = "(Optional) The network range used by the AKS Cluster. Changing this forces a new resource to be created."
  default     = null
}

variable "network_plugin" {
  type        = string
  description = "Network plugin to use for networking. Defaults to Azure CNI. (`azure`)"
  default     = "azure"
  nullable    = false
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

variable "only_critical_addons_enabled" {
  type        = bool
  description = "(Optional) Enabling this option will taint default node pool with `CriticalAddonsOnly=true:NoSchedule` taint. Changing this forces a new resource to be created."
  default     = null
}

variable "open_service_mesh_enabled" {
  type        = bool
  description = "(Optional) Enables Open Service Mesh. For more details, please visit [Open Service Mesh for AKS](https://docs.microsoft.com/azure/aks/open-service-mesh-about)."
  default     = false
  nullable   = false
}

variable "private_cluster_enabled" {
  type        = bool
  description = "If true cluster API server will be exposed only on internal IP address and available only in cluster vnet."
  default     = false
}

variable "private_cluster_public_fqdn_enabled" {
  type        = bool
  description = "(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to `false`."
  default     = false
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

variable "rbac_aad" {
  type        = bool
  description = "(Optional) Is Azure Active Directory ingration enabled?"
  default     = true
  nullable    = false
}

variable "rbac_aad_admin_group_object_ids" {
  type        = list(string)
  description = "Object ID of groups with admin access."
  default     = null
}

variable "rbac_aad_azure_rbac_enabled" {
  type        = bool
  description = "(Optional) Is Role Based Access Control based on Azure AD enabled?"
  default     = null
}

variable "rbac_aad_client_app_id" {
  type        = string
  description = "The Client ID of an Azure Active Directory Application."
  default     = null
}

variable "rbac_aad_managed" {
  type        = bool
  description = "Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration."
  default     = false
  nullable    = false
}

variable "rbac_aad_server_app_id" {
  type        = string
  description = "The Application ID of an Azure Active Directory Application."
  default     = null
}

variable "rbac_aad_server_app_secret" {
  type        = string
  description = "The Application Secret of an Azure Active Directory Application."
  default     = null
}

variable "rbac_aad_tenant_id" {
  type        = string
  description = "(Optional) The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used."
  default     = null
}

variable "role_based_access_control_enabled" {
  type        = bool
  description = "(Optional) Enable Role Based Access Control."
  default     = false
  nullable    = false
}

variable "scale_down_mode" {
  type        = string
  description = "(Optional) Specifies the autoscaling behaviour of the AKS Cluster. If not specified, it defaults to `Delete`. Possible values include `Delete` and `Deallocate`. Changing this forces a new resource to be created."
  default     = "Delete"
}

variable "secret_rotation_enabled" {
  type        = bool
  description = "(Optional) Is secret rotation enabled? This variable is only used when `key_vault_secrets_provider_enabled` is `true` and defaults to `false`"
  default     = false
  nullable    = false
}

variable "secret_rotation_interval" {
  type        = string
  description = "The interval to poll for secret rotation. This attribute is only set when `secret_rotation` is `true` and defaults to `2m`"
  default     = "2m"
  nullable    = false
}

variable "sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this AKS Cluster. Possible values are `Free` and `Paid`"
  default     = "Free"
}

variable "storage_profile_blob_driver_enabled" {
  type        = bool
  description = "(Optional) Is the Blob CSI driver enabled? Defaults to `false`"
  default     = false
}

variable "storage_profile_disk_driver_enabled" {
  type        = bool
  description = "(Optional) Is the Disk CSI driver enabled? Defaults to `true`"
  default     = true
}

variable "storage_profile_disk_driver_version" {
  type        = string
  description = "(Optional) Disk CSI Driver version to be used. Possible values are `v1` and `v2`. Defaults to `v1`."
  default     = "v1"
}

variable "storage_profile_enabled" {
  description = "(Optional) Enable storage profile"
  type        = bool
  default     = false
  nullable    = false
}

variable "storage_profile_file_driver_enabled" {
  type        = bool
  description = "(Optional) Is the File CSI driver enabled? Defaults to `true`"
  default     = true
}

variable "storage_profile_snapshot_controller_enabled" {
  type        = bool
  description = "(Optional) Is the Snapshot Controller enabled? Defaults to `true`"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the AKS Cluster resources"
  default     = {}
}

variable "ultra_ssd_enabled" {
  type        = bool
  description = "(Optional) Used to specify whether the Ultra SSD is enabled in the Default Node Pool. Defaults to false."
  default     = false
}

variable "vnet_subnet_id" {
  type        = string
  description = "(Optional) The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "workload_identity_enabled" {
  description = "(Optional) Enable or Disable Workload Identity. Defaults to false."
  type        = bool
  default     = false
}
