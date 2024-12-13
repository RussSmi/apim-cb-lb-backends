targetScope = 'resourceGroup'

param serviceId string
param apimName string
param env string = 'dev'
param backendNames object = {
  backends: [
    {
      name: 'aoaibackend1'
      uri: 'https://'
    }
    {
      name: 'aoaibackend1'
      uri: 'https://'
    }    
  ]
}

module apimpool 'modules/apibackendpool.bicep' = {
  name: 'apimpool'
  scope: resourceGroup()
  params: {
    serviceId: serviceId
    apimName: apimName
    backendNames: backendNames
    env: env
  }
}
