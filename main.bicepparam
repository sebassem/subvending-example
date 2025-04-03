using './main.bicep'

param subscriptionBillingScope = ''
param subscriptionAliasName = 'dep-sub-hr-phoenix'
param subscriptionDisplayName = 'dep-sub-hr-phoenix'
param subscriptionWorkload = 'Production'
param subscriptionTags = {
  workload: 'phoenix'
  department: 'hr'
}
param virtualNetworkEnabled = true
param virtualNetworkName = 'vnet-hr-phoenix'
param virtualNetworkResourceGroupName = 'rg-hr-phoenix'
param virtualNetworkAddressSpace = [
  '10.0.0.0/16'
]
param virtualNetworkLocation = 'eastus'
param virtualNetworkSubnets = [
  {
    name: 'Subnet1'
    addressPrefix: '10.130.1.0/24'
  }
  {
    name: 'AzureBastionSubnet'
    addressPrefix: '10.130.0.0/26'
  }
]
param virtualNetworkBastionConfiguration = {
  bastionSku: 'Premium'
  name: 'bastion-hr-phoenix'
  enableFileCopy: true
  enableIpConnect: true
  enablePrivateOnlyBastion: false
}
param virtualNetworkDeployBastion = true
param resourceProviders = {
  'Microsoft.HybridCompute': ['ArcServerPrivateLinkPreview']
  'Microsoft.AVS': ['AzureServicesVm']
  'Microsoft.Network': []
}
param roleAssignments = [
  {
    principalId: 'XXXXX-XXXXX-XXXXXX-XXXXXX'
    definition: '/providers/Microsoft.Authorization/roleDefinitions/f58310d9-a9f6-439a-9e8d-f62e7b41a168'
    relativeScope: ''
    principalType: 'User'
    roleAssignmentCondition: {
      roleConditionType: {
        principleTypesToAssign: [
          'Group'
          'User'
        ]
        rolesToAssign: [
          'b24988ac-6180-42a0-ab88-20f7382dd24c'
        ]
        templateName: 'constrainRolesAndPrincipalTypes'
      }
    }
  }
]
