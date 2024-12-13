targetScope = 'resourceGroup'
param serviceId string
param apimName string
param env string = 'dev'

param backendNames object = {
  backends: [
    {
      name: 'aoaibackend1'
      uri: 'https://'
      isCB: true
    }
    {
      name: 'aoaibackend1'
      uri: 'https://'
      isCB: true
    }    
  ]
}

module backends 'backend.bicep' = [for backend in backendNames.backends: {
  name: 'backend-deploy-${env}-${backend.name}'
  //scope: resourceGroup()
  params: {
    serviceId: serviceId
    backendName: backend.name
    backendUri: backend.uri
    apiManagementServiceName: apimName
    isCB: backend.isCB
  }
}]


resource apiManagementService 'Microsoft.ApiManagement/service@2023-03-01-preview' existing = {
  name: apimName
  scope: resourceGroup()
}

resource mbebpool 'Microsoft.ApiManagement/service/backends@2024-05-01' = {
  name: '${serviceId}pool'
  parent: apiManagementService
  properties: {
    title: '${serviceId}pool'
    description: 'Load balance backend instances'
    type: 'Pool'
    pool: {
      services: [
        for (backend,i) in backendNames.backends: {
          id: '/backends/${backends[i].outputs.backendId}'
          priority: i + 1
          weight: i + 1
        }
      ]
  }
}
}

