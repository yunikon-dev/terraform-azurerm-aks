# terraform-azurerm-aks module

<a name="readme-top"></a>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

## About The Project
Terraform module.

## Getting Started
To get a local copy up and running, follow these simple example steps.

### Prerequisites
* Terraform: [learn.hashicorp.com: Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

### Installation

#### Remote
1. Include this module in your Terraform code from the source
  ```hcl
  module {
    source = "github.com/yunikon-nl/terraform-azurerm-aks"
  }
  ```
2. Initialize your project to download the module
  ```sh
  terraform init
  ```

#### Local
1. Go into your local Terraform project
  ```sh
  cd /my/terraform/project
  ```
2. Create a modules/ folder:
  ```sh
  mkdir modules/
  ```
3. Clone the repo
  ```sh
  git clone https://github.com/yunikon-nl/terraform-azurerm-aks.git modules/
  ```
4. Include this module in your Terraform code from the source
  ```hcl
  module {
    source = "modules/terraform-azurerm-aks"
  }
  ```
5. Initialize your project to test the module
  ```sh
   terraform init
  ```

## Usage
[//]: # (BEGIN_TF_DOCS)
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.40.0 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_kubernetes_cluster.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_log_analytics_solution.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_solution) | resource |
| [azurerm_log_analytics_workspace.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_private_dns_zone.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_endpoint.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.dns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [time_sleep.aks_creation_delay](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [tls_private_key.ssh](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azuread_group.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_node_pool"></a> [default\_node\_pool](#input\_default\_node\_pool) | (Required) Default Node Pool variables. Refer to the [azurerm\_kubernetes\_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables. | <pre>object({<br>    name                         = optional(string, "default")<br>    vm_size                      = optional(string, "Standard_B2s")<br>    enable_auto_scaling          = optional(bool, true)<br>    enable_host_encryption       = optional(bool)<br>    enable_node_public_ip        = optional(string)<br>    max_count                    = optional(number)<br>    max_pods                     = optional(number, 50)<br>    min_count                    = optional(number, 1)<br>    node_count                   = optional(number, 1)<br>    node_labels                  = optional(map(string))<br>    node_taints                  = optional(list(string), null)<br>    only_critical_addons_enabled = optional(bool, null)<br>    orchestrator_version         = optional(string)<br>    os_disk_size_gb              = optional(number, 40)<br>    os_disk_type                 = optional(string)<br>    pod_subnet_id                = optional(string)<br>    scale_down_mode              = optional(string)<br>    tags                         = optional(map(string), null)<br>    type                         = optional(string, "VirtualMachineScaleSets")<br>    ultra_ssd_enabled            = optional(bool, false)<br>    vnet_subnet_id               = optional(string)<br>    zones                        = optional(list(number), [1, 2, 3])<br>  })</pre> | n/a | yes |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | (Optional) DNS prefix specified when creating the Managed Kubernetes Cluster. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_api_server_access_profile"></a> [api\_server\_access\_profile](#input\_api\_server\_access\_profile) | (Optional) Controls access options of the API server. `vnet_integration_enabled` is currently in Preview. Be aware that Microsoft's Preview features are untested and may never graduate to General Availability. | <pre>object({<br>    authorized_ip_ranges     = optional(list(string))<br>    subnet_id                = optional(string)<br>    vnet_integration_enabled = optional(bool, false)<br>  })</pre> | `null` | no |
| <a name="input_auto_scaler_profile"></a> [auto\_scaler\_profile](#input\_auto\_scaler\_profile) | (Optional) Auto scaler variables. Only used when `enable_auto_scaling` is set to `true`. Refer to the [azurerm\_kubernetes\_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables. | <pre>object({<br>    balance_similar_node_groups      = optional(bool)<br>    empty_bulk_delete_max            = optional(number)<br>    expander                         = optional(string)<br>    max_graceful_termination_sec     = optional(number)<br>    max_node_provisioning_time       = optional(string)<br>    max_unready_nodes                = optional(number)<br>    max_unready_percentage           = optional(number)<br>    new_pod_scale_up_delay           = optional(string)<br>    scale_down_delay_after_add       = optional(string)<br>    scale_down_delay_after_delete    = optional(string)<br>    scale_down_delay_after_failure   = optional(string)<br>    scale_down_unneeded              = optional(string)<br>    scale_down_unready               = optional(string)<br>    scale_down_utilization_threshold = optional(string)<br>    scan_interval                    = optional(string)<br>    skip_nodes_with_local_storage    = optional(bool)<br>    skip_nodes_with_system_pods      = optional(bool)<br>  })</pre> | <pre>{<br>  "balance_similar_node_groups": null,<br>  "empty_bulk_delete_max": null,<br>  "expander": null,<br>  "max_graceful_termination_sec": null,<br>  "max_node_provisioning_time": null,<br>  "max_unready_nodes": null,<br>  "max_unready_percentage": null,<br>  "new_pod_scale_up_delay": null,<br>  "scale_down_delay_after_add": null,<br>  "scale_down_delay_after_delete": null,<br>  "scale_down_delay_after_failure": null,<br>  "scale_down_unneeded": null,<br>  "scale_down_unready": null,<br>  "scale_down_utilization_threshold": null,<br>  "scan_interval": null,<br>  "skip_nodes_with_local_storage": null,<br>  "skip_nodes_with_system_pods": null<br>}</pre> | no |
| <a name="input_automatic_channel_upgrade"></a> [automatic\_channel\_upgrade](#input\_automatic\_channel\_upgrade) | (Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image, and stable. By default, automatic upgrades are turned off. Note that you cannot use the patch upgrade channel and still specify the patch version using kubernetes\_version. See the documentation for more information. | `string` | `null` | no |
| <a name="input_azure_active_directory_role_based_access_control"></a> [azure\_active\_directory\_role\_based\_access\_control](#input\_azure\_active\_directory\_role\_based\_access\_control) | (Optional) Azure Active Directory RBAC variables. When `managed` is set to `true`, `admin_group_object_ids` must be given the `object_id`s of an Azure AD Group and `azure_rbac_enabled` can be specified. Refer to the [azurerm\_kubernetes\_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables. | <pre>object({<br>    managed                = optional(bool)<br>    tenant_id              = optional(string)<br>    admin_group_object_ids = optional(list(string))<br>    azure_rbac_enabled     = optional(bool)<br>    client_app_id          = optional(string)<br>    server_app_id          = optional(string)<br>    server_app_secret      = optional(string)<br>  })</pre> | <pre>{<br>  "admin_group_object_ids": null,<br>  "azure_rbac_enabled": null,<br>  "client_app_id": null,<br>  "managed": null,<br>  "server_app_id": null,<br>  "server_app_secret": null,<br>  "tenant_id": null<br>}</pre> | no |
| <a name="input_azure_active_directory_role_based_access_control_enabled"></a> [azure\_active\_directory\_role\_based\_access\_control\_enabled](#input\_azure\_active\_directory\_role\_based\_access\_control\_enabled) | (Optional) Enables support for Azure Active Directory RBAC. | `bool` | `false` | no |
| <a name="input_azure_policy_enabled"></a> [azure\_policy\_enabled](#input\_azure\_policy\_enabled) | (Optional) Should the Azure Policy Add-On be enabled? For more details, please visit [Understand Azure Policy for Azure Kubernetes Service](https://docs.microsoft.com/en-ie/azure/governance/policy/concepts/rego-for-aks). | `bool` | `false` | no |
| <a name="input_azuread_groups"></a> [azuread\_groups](#input\_azuread\_groups) | List of Azure AD Group names that will be assigned Administrator permissions on the Kubernetes Cluster. | `list(any)` | `[]` | no |
| <a name="input_azurerm_private_endpoint"></a> [azurerm\_private\_endpoint](#input\_azurerm\_private\_endpoint) | (Optional) Private Endpoint for the Kubernetes Cluster. | <pre>map(object({<br>    subnet_id            = optional(string)<br>    private_dns_zone_ids = optional(list(string), [])<br>    is_manual_connection = optional(bool, false)<br>    subresource_names    = optional(list(string), ["management"])<br>  }))</pre> | `{}` | no |
| <a name="input_container_registry"></a> [container\_registry](#input\_container\_registry) | (Optional) Container Registry variables. When defined, creates a Container Registry and a role assignment that grants the Kubernetes Cluster `AcrPull` permissions. Refer to the [azurem\_container\_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) documentation for more information on these variables. | <pre>object({<br>    name = string<br>    sku  = optional(string, "Standard")<br>    tags = optional(map(string))<br>  })</pre> | `null` | no |
| <a name="input_container_registry_enabled"></a> [container\_registry\_enabled](#input\_container\_registry\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_create_analytics_solution"></a> [create\_analytics\_solution](#input\_create\_analytics\_solution) | (Optional) Create a Log Analytics Solution for Kubernetes. | `bool` | `false` | no |
| <a name="input_create_analytics_workspace"></a> [create\_analytics\_workspace](#input\_create\_analytics\_workspace) | (Optional) Create a Log Analytics Workspace for Kubernetes. | `bool` | `false` | no |
| <a name="input_create_custom_private_dns_zone"></a> [create\_custom\_private\_dns\_zone](#input\_create\_custom\_private\_dns\_zone) | (Optional) Creates a custom Private DNS Zone that is not managed by the Kubernetes Cluster. | `bool` | `false` | no |
| <a name="input_create_log_analytics_solution"></a> [create\_log\_analytics\_solution](#input\_create\_log\_analytics\_solution) | (Optional) Creates a Log Analytics Solution dedicated to the Kubernetes Cluster. | `bool` | `false` | no |
| <a name="input_create_log_analytics_workspace"></a> [create\_log\_analytics\_workspace](#input\_create\_log\_analytics\_workspace) | (Optional) Creates a Log Analytics Workspace dedicated to the Kubernetes Cluster. | `bool` | `false` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | (Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. More information [can be found in the documentation](https://docs.microsoft.com/azure/aks/azure-disk-customer-managed-keys). Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_http_application_routing_enabled"></a> [http\_application\_routing\_enabled](#input\_http\_application\_routing\_enabled) | (Optional) Should HTTP Application Routing be enabled? | `bool` | `false` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this AKS Cluster. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | (Optional) The type of identity used for the managed cluster. Conflict with `client_id` and `client_secret`. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`(to enable both). If `UserAssigned` or `SystemAssigned, UserAssigned` is set, an `identity_ids` must be set as well. | `string` | `"SystemAssigned"` | no |
| <a name="input_image_cleaner_enabled"></a> [image\_cleaner\_enabled](#input\_image\_cleaner\_enabled) | (Optional, Preview) Enables the Image Cleaner. | `bool` | `false` | no |
| <a name="input_image_cleaner_interval_hours"></a> [image\_cleaner\_interval\_hours](#input\_image\_cleaner\_interval\_hours) | (Optional, Preview) Controls the Image Cleaner interval in hours. | `number` | `48` | no |
| <a name="input_ingress_application_gateway"></a> [ingress\_application\_gateway](#input\_ingress\_application\_gateway) | (Optional) Application Gateway Ingress Controller variables. Create an Application Gateway and pass the required variables to this module. Refer to the [azurerm\_kubernetes\_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables. | <pre>object({<br>    gateway_id   = optional(string)<br>    gateway_name = optional(string)<br>    subnet_cidr  = optional(string)<br>    subnet_id    = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_key_vault_secrets_provider"></a> [key\_vault\_secrets\_provider](#input\_key\_vault\_secrets\_provider) | (Optional) Set the configurable options for the Key Vault Secrets provider. Refer to the [azurerm\_kubernetes\_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables. | <pre>object({<br>    secret_rotation_enabled  = optional(bool)<br>    secret_rotation_interval = optional(string)<br>  })</pre> | <pre>{<br>  "secret_rotation_enabled": true,<br>  "secret_rotation_interval": "5m"<br>}</pre> | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | (Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade). AKS does not require an exact patch version to be specified, minor version aliases such as `1.22` are also supported. The minor version's latest GA patch is automatically chosen in that case. More details can be found in [the documentation](https://docs.microsoft.com/en-us/azure/aks/supported-kubernetes-versions?tabs=azure-cli#alias-minor-version). | `string` | `null` | no |
| <a name="input_linux_profile"></a> [linux\_profile](#input\_linux\_profile) | (Optional) Sets the user profile options for Linux OS node pools. | <pre>object({<br>    admin_username = optional(string)<br>    key_data       = optional(string)<br>  })</pre> | <pre>{<br>  "admin_username": "azureadmin",<br>  "key_data": null<br>}</pre> | no |
| <a name="input_load_balancer_profile"></a> [load\_balancer\_profile](#input\_load\_balancer\_profile) | (Optional) Load balancer variables. Only used when `load_balancer_sku` is set to `standard`. Refer to the [azurerm\_kubernetes\_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables. | <pre>object({<br>    idle_timeout_in_minutes     = optional(number)<br>    managed_outbound_ip_count   = optional(number)<br>    managed_outbound_ipv6_count = optional(number)<br>    outbound_ip_address_ids     = optional(list(string))<br>    outbound_ip_prefix_ids      = optional(list(string))<br>    outbound_ports_allocated    = optional(number)<br>  })</pre> | <pre>{<br>  "idle_timeout_in_minutes": null,<br>  "managed_outbound_ip_count": null,<br>  "managed_outbound_ipv6_count": null,<br>  "outbound_ip_address_ids": null,<br>  "outbound_ip_prefix_ids": null,<br>  "outbound_ports_allocated": null<br>}</pre> | no |
| <a name="input_local_account_disabled"></a> [local\_account\_disabled](#input\_local\_account\_disabled) | (Optional) If true local accounts will be disabled. See [the documentation](https://docs.microsoft.com/azure/aks/managed-aad#disable-local-accounts) for more information. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_log_analytics_solution"></a> [log\_analytics\_solution](#input\_log\_analytics\_solution) | (Optional) Creates a Log Analytics Solution dedicated to the cluster. Requires `create_log_analytics_workspace` to be set to `true`. | <pre>object({<br>    location = optional(string, null)<br>    tags     = optional(map(string), null)<br>  })</pre> | <pre>{<br>  "location": null,<br>  "tags": null<br>}</pre> | no |
| <a name="input_log_analytics_workspace"></a> [log\_analytics\_workspace](#input\_log\_analytics\_workspace) | (Optional) Sets the variables for the Log Analytics Workspace for this cluster. Refer to the [azurerm\_kubernetes\_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables. | <pre>object({<br>    location            = optional(string, null)<br>    name                = optional(string, null)<br>    resource_group_name = optional(string, null)<br>    retention_in_days   = optional(number, null)<br>    sku                 = optional(string, null)<br>    tags                = optional(map(string), null)<br>  })</pre> | <pre>{<br>  "location": null,<br>  "name": null,<br>  "resource_group_name": null,<br>  "retention_in_days": null,<br>  "sku": null,<br>  "tags": null<br>}</pre> | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | (Preview, Optional) The desired maintenance windows for the cluster. Currently, performing maintenance operations are considered best-effort only and are not guaranteed to occur within a specified window. Refer to the [azurerm\_kubernetes\_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables. | <pre>object({<br>    allowed = list(object({<br>      day   = string<br>      hours = set(number)<br>    })),<br>    not_allowed = list(object({<br>      end   = string<br>      start = string<br>    })),<br>  })</pre> | `null` | no |
| <a name="input_microsoft_defender_enabled"></a> [microsoft\_defender\_enabled](#input\_microsoft\_defender\_enabled) | (Optional) Enables Microsoft Defender for the Kubernetes Cluster. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The name for the Azure Kubernetes Service resources created in the specified Resource Group. | `string` | `null` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | (Optional) Sets up Network Policy to be used with Azure CNI. Network Policy allows control of the traffic flow between pods. Currently supported values are `calico` and `azure`. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_network_profile"></a> [network\_profile](#input\_network\_profile) | (Required) Networking variables. Refer to the [azurerm\_kubernetes\_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables. | <pre>object({<br>    network_plugin     = optional(string, "azure")<br>    dns_service_ip     = optional(string)<br>    docker_bridge_cidr = optional(string)<br>    load_balancer_sku  = optional(string)<br>    network_policy     = optional(string)<br>    outbound_type      = optional(string)<br>    pod_cidr           = optional(string)<br>    service_cidr       = optional(string)<br>  })</pre> | <pre>{<br>  "dns_service_ip": null,<br>  "docker_bridge_cidr": null,<br>  "load_balancer_sku": null,<br>  "network_plugin": null,<br>  "network_policy": null,<br>  "outbound_type": null,<br>  "pod_cidr": null,<br>  "service_cidr": null<br>}</pre> | no |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | (Optional) Additional Node Pool variables. Refer to the [azurerm\_kubernetes\_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) documentation for more information on these variables. | <pre>map(object({<br>    vm_size                      = optional(string, "Standard_F4s")<br>    enable_auto_scaling          = optional(bool, true)<br>    enable_host_encryption       = optional(bool)<br>    enable_node_public_ip        = optional(string)<br>    max_count                    = optional(number)<br>    max_pods                     = optional(number, 50)<br>    min_count                    = optional(number)<br>    node_count                   = optional(number)<br>    node_labels                  = optional(map(string))<br>    node_taints                  = optional(list(string), [])<br>    only_critical_addons_enabled = optional(bool)<br>    orchestrator_version         = optional(string)<br>    os_disk_size_gb              = optional(number)<br>    os_disk_type                 = optional(string)<br>    pod_subnet_id                = optional(string)<br>    scale_down_mode              = optional(string)<br>    tags                         = optional(map(string), null)<br>    type                         = optional(string)<br>    ultra_ssd_enabled            = optional(bool)<br>    vnet_subnet_id               = optional(string)<br>    zones                        = optional(list(number))<br>  }))</pre> | `{}` | no |
| <a name="input_node_resource_group"></a> [node\_resource\_group](#input\_node\_resource\_group) | (Optional) The auto-generated Resource Group which contains the resources for the Kubernetes Cluster. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_oidc_issuer_enabled"></a> [oidc\_issuer\_enabled](#input\_oidc\_issuer\_enabled) | (Optional) Enable or Disable the OIDC issuer URL. Defaults to false. | `bool` | `false` | no |
| <a name="input_oms_agent_enabled"></a> [oms\_agent\_enabled](#input\_oms\_agent\_enabled) | (Optional) Enables the OMS Agent for the Kubernetes Cluster. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_open_service_mesh_enabled"></a> [open\_service\_mesh\_enabled](#input\_open\_service\_mesh\_enabled) | (Optional) Enables Open Service Mesh. For more details, please visit [Open Service Mesh for AKS](https://docs.microsoft.com/azure/aks/open-service-mesh-about). | `bool` | `false` | no |
| <a name="input_preview_features_enabled"></a> [preview\_features\_enabled](#input\_preview\_features\_enabled) | (Optional) Enables Preview features on the Kubernetes Cluster. Warning: Do not enable this in production. | `bool` | `false` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | (Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to `false`. Changing this forces a new resource to be created. | `bool` | `true` | no |
| <a name="input_private_cluster_public_fqdn_enabled"></a> [private\_cluster\_public\_fqdn\_enabled](#input\_private\_cluster\_public\_fqdn\_enabled) | (Optional) Specifies whether a Public FQDN for this Private Kubernetes Cluster should be added. Defaults to `false`. | `bool` | `true` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | (Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, `System` to have AKS manage this or `None`. In case of `None` you will need to bring your own DNS server and set up resolving, otherwise, the cluster will have issues after provisioning. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Enables public access to the Kubernetes Cluster API. | `bool` | `false` | no |
| <a name="input_role_based_access_control_enabled"></a> [role\_based\_access\_control\_enabled](#input\_role\_based\_access\_control\_enabled) | (Optional) Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created. | `bool` | `true` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | (Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are `Free` and `Paid` (which includes the Uptime SLA). Defaults to `Free`. | `string` | `"Free"` | no |
| <a name="input_storage_profile"></a> [storage\_profile](#input\_storage\_profile) | (Optional) Storage variables. Enables support for blobs, disks, file shares and snapshotting. Refer to the [azurerm\_kubernetes\_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) documentation for more information on these variables. | <pre>object({<br>    blob_driver_enabled         = bool<br>    disk_driver_enabled         = bool<br>    disk_driver_version         = string<br>    file_driver_enabled         = bool<br>    snapshot_controller_enabled = bool<br>  })</pre> | <pre>{<br>  "blob_driver_enabled": true,<br>  "disk_driver_enabled": true,<br>  "disk_driver_version": "v1",<br>  "file_driver_enabled": true,<br>  "snapshot_controller_enabled": true<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `null` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | (Optional) ID of the Virtual Network to link the custom Private DNS Zone with. | `string` | `null` | no |
| <a name="input_workload_autoscaler_profile"></a> [workload\_autoscaler\_profile](#input\_workload\_autoscaler\_profile) | (Optional, Preview) Controls the Workload Autoscaler. Refer to [the documentation](https://learn.microsoft.com/en-us/azure/aks/workload-identity-deploy-cluster#register-the-enableworkloadidentitypreview-feature-flag) for more information. | <pre>object({<br>    keda_enabled = optional(bool, true)<br>  })</pre> | `null` | no |
| <a name="input_workload_identity_enabled"></a> [workload\_identity\_enabled](#input\_workload\_identity\_enabled) | (Optional, Preview), Enable or disable Workload Identity. Defaults to `false`. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_container_registry"></a> [azurerm\_container\_registry](#output\_azurerm\_container\_registry) | Details of the Container Registry. |
| <a name="output_azurerm_private_dns_zone"></a> [azurerm\_private\_dns\_zone](#output\_azurerm\_private\_dns\_zone) | Details of the Private DNS Zone. |
| <a name="output_azurerm_private_endpoint"></a> [azurerm\_private\_endpoint](#output\_azurerm\_private\_endpoint) | Details of the Private Endpoint. |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Name of the Kubernetes Cluster. |
| <a name="output_kubernetes_cluster"></a> [kubernetes\_cluster](#output\_kubernetes\_cluster) | Details of the Kubernetes Cluster. |
| <a name="output_log_analytics_solution"></a> [log\_analytics\_solution](#output\_log\_analytics\_solution) | Details of the Log Analytics Solution. |
| <a name="output_log_analytics_workspace"></a> [log\_analytics\_workspace](#output\_log\_analytics\_workspace) | Details of the Log Analytics Workspace. |
| <a name="output_node_pools"></a> [node\_pools](#output\_node\_pools) | Details of all additional Node Pools. |
| <a name="output_tls_private_key"></a> [tls\_private\_key](#output\_tls\_private\_key) | Details of the generated TLS Private Key. |
| <a name="output_user_assigned_identity"></a> [user\_assigned\_identity](#output\_user\_assigned\_identity) | Details of the Kubernetes Cluster's User Assigned Identity. |

[//]: # (END_TF_DOCS)

## Roadmap
- [x] Add Changelog
- [x] Add License
- [ ] Do something else

See the [open issues](https://github.com/yunikon-nl/terraform-azurerm-aks/issues) for a full list of proposed features (and known issues).

## Contributing
Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License
See [LICENSE.md](LICENSE.md) for more information.

## Contact
This code base is owned by Yunikon.


* Email: [code@yunikon.nl](mailto:code@yunikon.nl)


Project Link: [yunikon-nl/terraform-azurerm-aks](https://github.com/yunikon-nl/terraform-azurerm-aks)


## Acknowledgments