param privateEndpointName string 
param location string 
param storageAccountResourceId string 
param subnetRef string





resource privateEndpoint 'Microsoft.Network/privateEndpoints@2020-06-01' = {
  name: privateEndpointName
  location: location
  properties: {
    subnet: {
      id: subnetRef
    }
    privateLinkServiceConnections: [
      {
        name: privateEndpointName
        properties: {
          privateLinkServiceId: storageAccountResourceId
          groupIds: [
            'blob'
          ]
        }
      }
    ]
  }
}

output privateEndpointStorageBlobId string = privateEndpoint.id
