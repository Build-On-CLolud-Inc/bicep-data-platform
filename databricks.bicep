param env string 
param workspaceName string 
param location string
param tagValues object 
param virtualNetworkId string
param publicSubnetName string 
param privateSubnetName string 

var managedResourceGroupName = 'rg-mdb-sia-${env}-neu-01-${uniqueString(workspaceName, resourceGroup().id)}'
var managedResourceGroupId = '${subscription().id}/resourceGroups/${managedResourceGroupName}'


resource myDatabricks 'Microsoft.Databricks/workspaces@2021-04-01-preview' = {
  name: workspaceName
  location: location
  tags: tagValues
  sku: {
    name: 'Premium'
    tier: 'Premium'
  }
  properties: {
    managedResourceGroupId: managedResourceGroupId
    
    parameters: {
      customVirtualNetworkId: {
        value: virtualNetworkId
      }
      customPublicSubnetName: {
        value: publicSubnetName
      }
      customPrivateSubnetName: {
        value: privateSubnetName
      }
    }
  }
}


output databricksId string = myDatabricks.id
