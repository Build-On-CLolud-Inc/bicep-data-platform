param storageAccountName string 
param location string 
param skuName string =  'Standard_RAGRS'


resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: 'BlobStorage'
  properties:{
    isHnsEnabled:false
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

resource axbrzl 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' ={
  parent: blobService
  name: 'axbrzl'
  properties: {
    publicAccess: 'None'
  }
}

resource bfc 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' ={
  parent: blobService
  name: 'bfc'
  properties: {
    publicAccess: 'None'
  }
}

resource kantar 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' ={
  parent: blobService
  name: 'kantar'
  properties: {
    publicAccess: 'None'
  }
}

resource mcnmy 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' ={
  parent: blobService
  name: 'mcnmy'
  properties: {
    publicAccess: 'None'
  }
}



resource mcnmy25 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' ={
  parent: blobService
  name: 'mcnmy25'
  properties: {
    publicAccess: 'None'
  }
}


resource navfran 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' ={
  parent: blobService
  name: 'navfran'
  properties: {
    publicAccess: 'None'
  }
}



resource navit 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' ={
  parent: blobService
  name: 'navit'
  properties: {
    publicAccess: 'None'
  }
}



resource onestream 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' ={
  parent: blobService
  name: 'onestream'
  properties: {
    publicAccess: 'None'
  }
}


output storageAccountId string = stg.id
