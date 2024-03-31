param privateEndpointName string 
param location string 
param kvResourceId string 
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
          privateLinkServiceId: kvResourceId
          groupIds: [
            'vault'
          ]
        }
      }
    ]
  }
}

output privateEndpointKvId string = privateEndpoint.id
