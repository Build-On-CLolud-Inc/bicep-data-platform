param vNetResourceId string 
param privateEndpointName string 
param vNetName string 
var privateDnsZonesName = '${privateEndpointName}.blob.${environment().suffixes.storage}'


resource privateDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  name: '${privateDnsZonesName}/${vNetName}-link'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vNetResourceId
    }
  }
}
