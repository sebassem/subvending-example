targetScope = 'managementGroup'

@description('Required. The scope of the subscription billing.')
param subscriptionBillingScope string = ''

@description('Optional. The name of the Subscription Alias, that will be created by this module.\n\nThe string must be comprised of `a-z`, `A-Z`, `0-9`, `-`, `_` and ` ` (space). The maximum length is 63 characters.\n\n> **Not required when providing an existing Subscription ID via the parameter `existingSubscriptionId`**.\n')
param subscriptionAliasName string = 'dep-sub-hr-phoenix'

@description('Optional. The name of the subscription alias. The string must be comprised of a-z, A-Z, 0-9, - and _. The maximum length is 63 characters.\n\nThe string must be comprised of `a-z`, `A-Z`, `0-9`, `-`, `_` and ` ` (space). The maximum length is 63 characters.\n\n> The value for this parameter and the parameter named `subscriptionAliasName` are usually set to the same value for simplicity. But they can be different if required for a reason.\n\n> **Not required when providing an existing Subscription ID via the parameter `existingSubscriptionId`**.\n')
param subscriptionDisplayName string = 'dep-sub-hr-phoenix'

@description('Optional. The workload type can be either `Production` or `DevTest` and is case sensitive.\n\n> **Not required when providing an existing Subscription ID via the parameter `existingSubscriptionId`**.\n')
param subscriptionWorkload 'DevTest' | 'Production' = 'Production'

@description('Optional. An object of Tag key & value pairs to be appended to a Subscription.\n\n> **NOTE:** Tags will only be overwritten if existing tag exists with same key as provided in this parameter; values provided here win.\n')
param subscriptionTags object = {
  workload: 'phoenix'
  department: 'hr'
}

@description('Optional. Whether to create a Virtual Network or not.\n\nIf set to `true` ensure you also provide values for the following parameters at a minimum:\n\n- `virtualNetworkResourceGroupName`\n- `virtualNetworkResourceGroupLockEnabled`\n- `virtualNetworkLocation`\n- `virtualNetworkName`\n- `virtualNetworkAddressSpace`\n\n> Other parameters may need to be set based on other parameters that you enable that are listed above. Check each parameters documentation for further information.\n')
param virtualNetworkEnabled bool = true

@description('Optional. The name of the virtual network. The string must consist of a-z, A-Z, 0-9, -, _, and . (period) and be between 2 and 64 characters in length.\n')
param virtualNetworkName string = 'vnet-hr-phoenix'

@description('Optional. The name of the Resource Group to create the Virtual Network in that is created by this module.\n')
param virtualNetworkResourceGroupName string = 'rg-hr-phoenix'

@description('Optional. The address space of the Virtual Network that will be created by this module, supplied as multiple CIDR blocks in an array, e.g. `["10.0.0.0/16","172.16.0.0/12"]`.')
param virtualNetworkAddressSpace string[]

@description('Optional. The location of the virtual network. Use region shortnames e.g. `uksouth`, `eastus`, etc. Defaults to the region where the ARM/Bicep deployment is targeted to unless overridden.\n')
param virtualNetworkLocation string

@description('Optional. The subnets of the Virtual Network that will be created by this module.')
param virtualNetworkSubnets array = []


@description('Optional. The configuration object for the Bastion host. Do not provide this object or keep it empty if you do not want to deploy a Bastion host.')
param virtualNetworkBastionConfiguration object = {}

@description('Optional. Whether to deploy a Bastion host to the created virtual network.')
param virtualNetworkDeployBastion bool = true

@description('Optional. An object of resource providers and resource providers features to register. If left blank/empty, no resource providers will be registered.\n')
param resourceProviders object = {}

@description('Optional. Supply an array of objects containing the details of the role assignments to create.\n\nEach object must contain the following `keys`:\n- `principalId` = The Object ID of the User, Group, SPN, Managed Identity to assign the RBAC role too.\n- `definition` = The Name of one of the pre-defined built-In RBAC Roles or a Resource ID of a Built-in or custom RBAC Role Definition as follows:\n  - You can only provide the RBAC role name of the pre-defined roles (Contributor, Owner, Reader, Role Based Access Control Administrator (Preview), and User Access Administrator). We only provide those roles as they are the most common ones to assign to a new subscription, also to reduce the template size and complexity in case we define each and every Built-in RBAC role.\n  - You can provide the Resource ID of a Built-in or custom RBAC Role Definition\n    - e.g. `/providers/Microsoft.Authorization/roleDefinitions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`\n- `relativeScope` = 2 options can be provided for input value:\n    1. `\'\'` *(empty string)* = Make RBAC Role Assignment to Subscription scope\n    2. `\'/resourceGroups/<RESOURCE GROUP NAME>\'` = Make RBAC Role Assignment to specified Resource Group.\n')
param roleAssignments array = []

module subVending 'br/public:avm/ptn/lz/sub-vending:0.3.0' = {
  params: {
    subscriptionAliasEnabled: true
    subscriptionBillingScope: subscriptionBillingScope
    subscriptionAliasName: subscriptionAliasName
    subscriptionDisplayName: subscriptionDisplayName
    subscriptionWorkload: subscriptionWorkload
    subscriptionTags: subscriptionTags
    virtualNetworkEnabled: virtualNetworkEnabled
    virtualNetworkName: virtualNetworkName
    virtualNetworkResourceGroupName: virtualNetworkResourceGroupName
    virtualNetworkAddressSpace: virtualNetworkAddressSpace
    virtualNetworkLocation: virtualNetworkLocation
    virtualNetworkSubnets: virtualNetworkSubnets
    virtualNetworkDeployBastion: virtualNetworkDeployBastion
    virtualNetworkBastionConfiguration: virtualNetworkBastionConfiguration
    resourceProviders: resourceProviders
    roleAssignments: roleAssignments
  }
}