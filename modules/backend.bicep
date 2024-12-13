param apiManagementServiceName string
param backendName string
param serviceId string  
param backendUri string
param isCB bool = false

resource apiManagementService 'Microsoft.ApiManagement/service@2023-03-01-preview' existing = {
  name: apiManagementServiceName
  scope: resourceGroup()
}

resource backends 'Microsoft.ApiManagement/service/backends@2023-09-01-preview' =  {
  name: '${serviceId}-${backendName}-backend'
  parent: apiManagementService
  properties: {
    url: backendUri
    protocol: 'http'
    description: 'Backend - ${backendName}'
    type: 'Single'
    circuitBreaker: (isCB == true ) ? {
      rules: [
        {
          acceptRetryAfter: true
          failureCondition: {
            count: 1
            interval: 'PT1M'
            statusCodeRanges: [
              {
                min: 429
                max: 429
              }
            ]
          }
          name: '${serviceId}-BreakerRule'
          tripDuration: 'PT1M'
        }
      ]
    } : null
  }
}

output backendId string = backends.name
