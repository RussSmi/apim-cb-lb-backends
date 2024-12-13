using './main.bicep'

param serviceId = ''  // use a short unique service id e.g. 'xyz123
param apimName = ''   // The name of the apim instance to deploy the backends to
param env = 'dev'     // 
param backendNames = {
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

