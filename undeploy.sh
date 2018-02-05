#!/bin/bash

resourceGroup="Cloudquiz-rg"

echo "Deleting a resource group."
az group delete --name $resourceGroup