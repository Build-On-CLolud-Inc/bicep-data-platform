param synapseWorkspaceName string 
param location string 
param storageAccountId string 
param storageAccountName  string
param storageConainer string 
param env string 
param sqlAdminUser string 
param sqlAdminPassword string 
param sqlPoolName string 

var storageDfsEndpointUrl = 'https://${storageAccountName}.dfs.${environment().suffixes.storage}/'
resource synapseWorkspace 'Microsoft.Synapse/workspaces@2021-06-01' = {
  name: synapseWorkspaceName
  location: location
  tags: {
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    defaultDataLakeStorage: {
      resourceId: storageAccountId
      createManagedPrivateEndpoint: true
      accountUrl: storageDfsEndpointUrl
      filesystem: storageConainer
    }
    managedVirtualNetwork: 'default'
    managedResourceGroupName: 'rg-msw-sia-${env}-neu-01'
    sqlAdministratorLogin: sqlAdminUser
    sqlAdministratorLoginPassword: sqlAdminPassword  
    privateEndpointConnections: []
    managedVirtualNetworkSettings: {
      preventDataExfiltration: true
      allowedAadTenantIdsForLinking: []
    }
    publicNetworkAccess: 'Disabled'
    // cspWorkspaceAdminProperties: {
    //   initialWorkspaceAdminObjectId: '#########################'
    // }
    trustedServiceBypassEnabled: true
  }
}
resource sqlPool 'Microsoft.Synapse/workspaces/sqlPools@2021-06-01' = {
  name: sqlPoolName
  location: location
  tags: {
    //tagName1: 'tagValue1'
    //tagName2: 'tagValue2'
  }
  sku: {
    capacity: 100
    name: 'DW100c'
    tier: 'DW100c'
  }
  parent: synapseWorkspace
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    createMode: 'Default'
    // maxSizeBytes: int
    // provisioningState: 'string'
    // recoverableDatabaseId: 'string'
    // restorePointInTime: 'string'
    // sourceDatabaseDeletionDate: 'string'
    // sourceDatabaseId: 'string'
    // storageAccountType: 'string'
  }
}
