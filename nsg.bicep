param nsgName string
param location string

resource nsg 'Microsoft.Network/networkSecurityGroups@2020-07-01' = {
  name: nsgName
  location: location
  tags: {}
  properties:{} 
}
