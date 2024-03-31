param privateEndpointName string 
param sqlServerName string 
param privateDnsZonesId string 

resource privateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-06-01' = {
  name: '${privateEndpointName}/${sqlServerName}'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'sqlconfig'
        properties: {
          privateDnsZoneId: privateDnsZonesId
        }
      }
    ]
  }
}
