#!/bin/bash

# Download from s3
aws s3 cp s3://ebdm-helm-charts . --recursive

# Package charts
for chart in $(ls charts/); do
  helm package charts/$chart
done

# Upload charts to s3
aws s3 cp . s3://ebdm-helm-charts --recursive --exclude "*" --include "*.tgz"

helm repo index --url https://ebdmuir.github.io/helm-charts/ .