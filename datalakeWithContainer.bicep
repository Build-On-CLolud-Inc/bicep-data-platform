resource datalake 'Microsoft.Storage/storageAccounts@2021-04-01' = if (deployDataLake == true) {
  name: 'fancy-name'
  location: resLocation
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    isHnsEnabled: true
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
    }
    encryption: {
      services: {
        blob: {
          enabled: true
        }
        file: {
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
}

/*
    I built this child resource by wroking my way back through these templates: https://github.com/Azure-Samples/Synapse/tree/main/Manage/DeployWorkspace/storage 
    It get's a little tricky, but we are building a dependency chain of parent-child resources. e.g. Storage account -> Blob -> Container
  */
  resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2021-04-01' = if (deployDataLake == true) {
    parent: datalake
    name: 'default'
    properties: {
      cors: {
         corsRules: []
      }
      deleteRetentionPolicy: {
        enabled: false
      }
    }
  }

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' = if (deployDataLake == true) {
  parent: blobService
  name: 'workspace'
  properties: {
    publicAccess: 'None'
  }
}
