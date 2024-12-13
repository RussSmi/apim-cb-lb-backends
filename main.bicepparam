using './main.bicep'

param serviceId = 'bepooltest'
param apimName = 'apim-lzv02-dev-uksouth-russ'
param env = 'dev'
param backendNames = {
  backends: [
    {
      name: 'aoaibackendptu'
      uri: 'https://lzv02-dev-uksouth-russopenai-ptu.openai.azure.com/openai/'
      isCB: true
    }
    {
      name: 'aoaibackendpayg'
      uri: 'https://lzv02-dev-uksouth-russopenai-paygo-one.openai.azure.com/openai/'
      isCB: true
    }
  ]
}

