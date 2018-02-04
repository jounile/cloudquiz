#!/bin/bash

# Create a resource group.
az group create --name Cloudquiz-rg --location "West Europe"

# Deploy ARM template.
az group deployment create \
    --name CloudquizDeployment \
    --resource-group Cloudquiz-rg \
    --template-file azuredeploy.json \
    --parameters @azuredeploy.parameters.json

# Deploy runtime resources


# Display the function path.
echo https://cloudquiz.azurewebsites.net
