#!/bin/bash

appName="cloudquiz"
location="WestEurope"
deploymentName="CloudquizDeployment"
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


echo "Package static website content"
cd client && zip -r $zipFile .

echo "Get MSDeploy publishing profile and query for publish URL and credentials"
creds=($(az webapp deployment list-publishing-profiles \
  --name $appName'-wa' \
  --resource-group $appName'-rg' \
  --query "[?contains(publishMethod, 'MSDeploy')].[publishUrl,userName,userPWD]" \
  --output tsv))

#echo "publishUrl: " ${creds[0]}
#echo "userName: " ${creds[1]}
#echo "userPWD: " ${creds[2]}

echo "Deploy ZIP file"
curl -X POST -u ${creds[1]}:${creds[2]} \
  --data-binary @./client/$zipFile "https://"$appName"-wa.scm.azurewebsites.net/api/zipdeploy?isAsync=true"

echo "Package functions"
cd ../functions && zip -r $functions .

echo "Deploy Function App"
az functionapp deployment source config-zip \
  --resource-group $appName'-rg' \
  --name $appName'-fa' \
  --src $functions

echo "Retrieve cosmosdb connection endpoint"
endpoint=$(az cosmosdb show \
  --name $appName'-ddb' \
  --resource-group $appName'-rg' \
  --query documentEndpoint \
  --output tsv)

echo $endpoint

echo "Retrieve cosmosdb connection key"
key=$(az cosmosdb list-keys \
  --name $appName'-ddb' \
  --resource-group $appName'-rg' \
  --query primaryMasterKey \
  --output tsv)

echo $key

echo "Configure cosmosdb connection for the function app env settings"
az functionapp config appsettings set \
  --name $appName'-fa' \
  --resource-group $appName'-rg' \
  --setting CosmosDBConnection='AccountEndpoint='$endpoint';AccountKey='$key';'

# Display the webapp path.
echo "https://"$appName"-wa.azurewebsites.net"