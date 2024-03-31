param kvName string
param kvSecretName string
param kvSecretValue string

resource keyVaultSecret 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
  name: '${kvName}/${kvSecretName}'
  properties: {
    value:kvSecretValue
  }
}
