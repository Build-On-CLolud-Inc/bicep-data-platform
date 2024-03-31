param kvname string
param location string
param applicationId string
param objectId string

resource keyVault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: kvname
  location: location
  properties: {
    accessPolicies: [      
    ]
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    tenantId: subscription().tenantId
    publicNetworkAccess:'disabled'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: []
      virtualNetworkRules: []
    }    
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}

resource keyVaultPolicies 'Microsoft.KeyVault/vaults/accessPolicies@2021-06-01-preview' = {
  name: '${keyVault.name}/add'
  properties: {    
    accessPolicies: [
      {
        applicationId: applicationId
        objectId: objectId
        permissions: {
          secrets: [
            'get'
            'list'
          ]
        }
        tenantId: subscription().tenantId
      }
    ]
  }
}  

output kvResourceId string = keyVault.id
