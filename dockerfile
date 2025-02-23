FROM mcr.microsoft.com/azure-cli  # Use the Azure CLI base image

LABEL "com.github.actions.name"="Azure Blob Sync Action"
LABEL "com.github.actions.description"="Uploads files to Azure Blob Storage and optionally purges Azure Front Door cache."
LABEL "com.github.actions.icon"="upload-cloud" 
LABEL "com.github.actions.color"="blue"

LABEL version="1.0." 
LABEL repository="https://github.com/mrguato/Azure-Blob-Sync-Action"
LABEL homepage="https://github.com/mrguato"
LABEL maintainer="Jonathan"

RUN apt-get update && apt-get install -y jq

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
