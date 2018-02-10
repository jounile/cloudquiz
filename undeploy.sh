#!/bin/bash

appName="cloudquiz"

echo "Deleting a resource group."
az group delete --name $appName'-rg'