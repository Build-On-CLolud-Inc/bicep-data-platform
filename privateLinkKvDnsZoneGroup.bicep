param privateEndpointName string 
param kvName string 
param privateDnsZonesId string 

resource privateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-06-01' = {
  name: '${privateEndpointName}/${kvName}'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'kvconfig'
        properties: {
          privateDnsZoneId: privateDnsZonesId
        }
      }
    ]
  }
}
