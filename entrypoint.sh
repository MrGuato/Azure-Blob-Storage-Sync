#!/bin/bash

# Azure Login (using environment variables)
az login --service-principal -u "$(echo "$AZURE_CREDENTIALS" | jq -r .clientId)" -p "$(echo "$AZURE_CREDENTIALS" | jq -r .clientSecret)" --tenant "$(echo "$AZURE_CREDENTIALS" | jq -r .tenantId)"

# Create Container
az storage container create --name "$CONTAINER_NAME" --account-name "$STORAGE_ACCOUNT_NAME" --auth-mode login --public-access off

# Upload to Blob Storage
az storage blob upload-batch --account-name "$STORAGE_ACCOUNT_NAME" --auth-mode login --source "frontend" --destination "$CONTAINER_NAME"

# Purge Front Door (conditional)
if [ -n "$RESOURCE_GROUP" ] && [ -n "$FRONTDOOR_NAME" ] && [ -n "$FRONTDOOR_ENDPOINT" ]; then
  az afd endpoint purge --resource-group "$RESOURCE_GROUP" --profile-name "$FRONTDOOR_NAME" --endpoint-name "$FRONTDOOR_ENDPOINT" --content-paths "/*" --no-wait
fi

echo "files synced to Azure Storage successfully!"
