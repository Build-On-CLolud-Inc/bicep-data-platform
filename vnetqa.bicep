param location string 
param vnetname string 
param nsgId string 
param commonSubnetAddress string 
param commonVMSubnetAddress string 
param vnetAddress string 
param privateSubnetAddress string 
param publicSubnetAddress string 
param privateSubnetName string 
param publicSubnetName string 
param commonSubnetName string 
param commonVMSubnetName string 




resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: vnetname
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddress
      ]
    }
    subnets: [
      {
        name: privateSubnetName
        properties: {
          addressPrefix: privateSubnetAddress
          networkSecurityGroup: nsgId == '' ? null : {
            id: nsgId
          }  
        }
      }
      {
        name:publicSubnetName
        properties: {
         privateEndpointNetworkPolicies : 'Disabled'
          addressPrefix: publicSubnetAddress
          networkSecurityGroup: nsgId == '' ? null : {
            id: nsgId
          }          
        }
      }
      {
        name: commonSubnetName
        properties: {
         privateEndpointNetworkPolicies : 'Disabled'
          addressPrefix: commonSubnetAddress
        }
      }      
      {
        name: commonVMSubnetName
        properties: {
         privateEndpointNetworkPolicies : 'Disabled'          
          addressPrefix: commonVMSubnetAddress
        }
      }       
    ]
  }
}

output vnetname string = vnetname
output vnettype string = virtualNetwork.type
output vnetId string = virtualNetwork.id
output databricksZeroSubNetId string = virtualNetwork.properties.subnets[0].id
output databricksOneSubNetId string = virtualNetwork.properties.subnets[1].id
output databricksTwoSubNetId string = virtualNetwork.properties.subnets[2].id
output databricksThreeSubNetId string = virtualNetwork.properties.subnets[3].id
