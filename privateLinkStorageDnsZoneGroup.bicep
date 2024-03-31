param privateEndpointName string 
param storageName string 
param privateDnsZonesId string 

resource privateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-06-01' = {
  name: '${privateEndpointName}/${storageName}'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'config1'
        properties: {
          privateDnsZoneId: privateDnsZonesId
        }
      }
    ]
  }
}
