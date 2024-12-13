# apim-cb-lb-backends

These bicep modules will add a pool and backends to an apim instance using a circuit breaker if specified.
Update the values in main.sample.bicepparam to match your environment.

To run this use the following command:
az deployment group create -g <-the Resource Group where the APIM instance is-> --parameters main.sample.bicepparam -n clideploy
