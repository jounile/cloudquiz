#!/bin/bash

appName="cloudquiz"
location="WestEurope"
deploymentName="CloudquizDeployment"
collectionName="quiz"
databaseName="answers"
originalThroughput=400
storageAccountName="CloudquizStorageAccount"
storageAccountType="Standard_GRS"
zipFile=$appName".zip"
functions="functions.zip"


echo "Create a resource group."
az group create --name $appName'-rg' --location $location

echo "Deploy ARM template."
az group deployment create \
    --name $deploymentName \
    --resource-group $appName'-rg' \
    --template-file azuredeploy.json \
    --parameters '{"dynamicAppServicePlanName": {"value": "'$appName'-dasp"},
    			   "appServicePlanName": {"value": "'$appName'-asp"},
    			   "functionAppName": {"value": "'$appName'-fa"},
    			   "webAppName": {"value": "'$appName'-wa"},
                   "documentDBName": {"value": "'$appName'-ddb"},
                   "storageAccountName": {"value": "'$storageAccountName'"},
                   "storageAccountType": {"value": "'$storageAccountType'"}}'

# Runtime resources 

#TODO: Check for DB existence

echo "Create database"
az cosmosdb database create \
	--name $appName'-ddb' \
	--db-name $databaseName \
	--resource-group $appName'-rg'

echo "Create collection"
az cosmosdb collection create \
	--collection-name $collectionName \
	--name $appName'-ddb' \
	--db-name $databaseName \
	--resource-group $appName'-rg' \
	--throughput $originalThroughput



#TODO: Migrate data

echo "Package static website content"
cd client && zip -r $zipFile .

echo "Get MSDeploy publishing profile and query for publish URL and credentials"
creds=($(az webapp deployment list-publishing-profiles \
	--name $appName'-wa' \
	--resource-group $appName'-rg' \
	--query "[?contains(publishMethod, 'MSDeploy')].[publishUrl,userName,userPWD]" \
	--output tsv))

echo "publishUrl: " ${creds[0]}
echo "userName: " ${creds[1]}
echo "userPWD: " ${creds[2]}

echo "Deploy ZIP file"
curl -X POST -u ${creds[1]} \
	--data-binary @./client/$zipFile "https://"$appName"-wa.scm.azurewebsites.net/api/zipdeploy?isAsync=true"

echo "Package functions"
cd ./functions && zip -r $functions .

echo "Deploy Function App"
az functionapp deployment source config-zip \
	--resource-group $appName'-rg' \
	--name $appName'-fa' \
	--src $functions

echo "Retrieve cosmosdb connection string"
endpoint=$(az cosmosdb show \
  --name $appName'-ddb' \
  --resource-group $appName'-rg' \
  --query documentEndpoint \
  --output tsv)

echo $endpoint

key=$(az cosmosdb list-keys \
  --name $appName'-ddb' \
  --resource-group $appName'-rg' \
  --query primaryMasterKey \
  --output tsv)

echo $key

# configure function app settings to use cosmosdb connection string
az functionapp config appsettings set \
  --name $appName'-fa' \
  --resource-group $appName'-rg' \
  --setting CosmosDB_Endpoint=$endpoint CosmosDB_Key=$key CosmosDBConnection=AccountEndpoint=$endpoint;AccountKey=$key;

# Display the webapp path.
echo "https://"$appName"-wa.azurewebsites.net"