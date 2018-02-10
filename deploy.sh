#!/bin/bash

appName="cloudquiz"
location="WestEurope"
deploymentName="CloudquizDeployment"
collectionName="quiz"
databaseName="answers"
originalThroughput=400
storageAccountName="CloudquizStorageAccount"
storageAccountType="Standard_GRS"


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
cd client && zip -r cloudquiz.zip .

echo "Get FTP publishing profile and query for publish URL and credentials"
creds=($(az webapp deployment list-publishing-profiles \
	--name $appName'-wa' \
	--resource-group $appName'-rg' \
	--query "[?contains(publishMethod, 'FTP')].[publishUrl,userName,userPWD]" \
	--output tsv))

echo "publishUrl: " ${creds[0]}
echo "userName: " ${creds[1]}
echo "userPWD: " ${creds[2]}


# Display the function path.
echo https://cloudquiz.azurewebsites.net
