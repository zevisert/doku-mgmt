#!/bin/bash
set -e
mkdir -p /home/gitlab-runner/.gitlab-runner/
cp /scripts/config.toml /home/gitlab-runner/.gitlab-runner/

# Set up environment variables for cache
if [[ -f /secrets/accesskey && -f /secrets/secretkey ]]; then
  export CACHE_S3_ACCESS_KEY=$(cat /secrets/accesskey)
  export CACHE_S3_SECRET_KEY=$(cat /secrets/secretkey)
fi

if [[ -f /secrets/gcs-application-credentials-file ]]; then
  export GOOGLE_APPLICATION_CREDENTIALS="/secrets/gcs-application-credentials-file"
else
  if [[ -f /secrets/gcs-access-id && -f /secrets/gcs-private-key ]]; then
    export CACHE_GCS_ACCESS_ID=$(cat /secrets/gcs-access-id)
    # echo -e used to make private key multiline (in google json auth key private key is oneline with \n)
    export CACHE_GCS_PRIVATE_KEY=$(echo -e $(cat /secrets/gcs-private-key))
  fi
fi

if [[ -f /secrets/azure-account-name && -f /secrets/azure-account-key ]]; then
  export CACHE_AZURE_ACCOUNT_NAME=$(cat /secrets/azure-account-name)
  export CACHE_AZURE_ACCOUNT_KEY=$(cat /secrets/azure-account-key)
fi

# Register the runner
if ! bash /scripts/register; then
  exit 1
fi

# Run pre-entrypoint-script
if ! bash /scripts/pre-entrypoint; then
  exit 1
fi

# Start the runner
exec /entrypoint run --user=gitlab-runner \
  --working-directory=/home/gitlab-runner
