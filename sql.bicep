param sqlServerName string
param sqlDatabaseName string
/*azsql-sia-dev-control-db*/
param location string


@secure()
param adminUser string 

@secure()
param adminPassword string 

resource sqlServer 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: adminUser
    administratorLoginPassword: adminPassword
    version: '12.0'
    publicNetworkAccess:'Disabled'
  }
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2014-04-01' = {
  parent:sqlServer
  name:sqlDatabaseName
  location:location
  properties:{
    collation:'SQL_Latin1_General_CP1_CI_AS'
    edition:'Standard'
  }
}


output sqlServerResourceId string = sqlServer.id
