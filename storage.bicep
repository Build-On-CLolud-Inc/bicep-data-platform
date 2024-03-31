param storageAccountName string 
param location string 
param skuName string =  'Standard_RAGRS'


resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
  properties:{
    isHnsEnabled:true
    accessTier: 'Hot'
    networkAcls: {
      bypass: 'None'
      defaultAction: 'Deny'
    }
  }
}


resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2021-04-01' = {
  parent: stg
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

resource synapseContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' ={
  parent: blobService
  name: 'synapse-workspace-files'
  properties: {
    publicAccess: 'None'
  }
}

resource dataContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' ={
  parent: blobService
  name: 'data'
  properties: {
    publicAccess: 'None'
  }
}

resource systemFilesContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' ={
  parent: blobService
  name: 'system-files'
  properties: {
    publicAccess: 'None'
  }
}

output storageAccountId string = stg.id
