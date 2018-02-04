#!/bin/bash

appName="cloudquiz"
location="WestEurope"
deploymentName="CloudquizDeployment"
resourceGroup="Cloudquiz-rg"
cosmosDbAccountName="cloudquiz"
collectionName="quiz"
databaseName="answers"
originalThroughput=400

echo "Create a resource group."
az group create --name $resourceGroup --location $location

echo "Deploy ARM template."
az group deployment create \
    --name $deploymentName \
    --resource-group $resourceGroup \
    --template-file azuredeploy.json \
    --parameters @azuredeploy.parameters.json

echo "Create database"
az cosmosdb database create \
	--name $appName \
	--db-name $databaseName \
	--resource-group $resourceGroup

echo "Create collection"
az cosmosdb collection create \
	--collection-name $collectionName \
	--name $cosmosDbAccountName \
	--db-name $databaseName \
	--resource-group $resourceGroup \
	--throughput $originalThroughput

#echo "Get the MongoDB URL"
#connectionString=$(az cosmosdb list-connection-strings \
#	--name $appName \
#	--resource-group $resourceGroup \
#	--query connectionStrings[0].connectionString \
#	--output tsv)

#echo connectionString

# Display the function path.
echo https://cloudquiz.azurewebsites.net
