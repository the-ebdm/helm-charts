#!/bin/bash

# This script packages up the helm charts and updates the index

for chart in $(ls charts/); do
  helm package charts/$chart
  # echo $chart
done

helm repo index --url https://ebdmuir.github.io/helm-charts/ .

git add -A
git commit -m "Update charts and index"
git push

CURRENT_GEN=$(cat index.yaml | yq -r '.generated')
LAST_GEN=$(curl -s https://ebdmuir.github.io/helm-charts/index.yaml | yq -r '.generated')

echo $LAST_GEN

while [ "$CURRENT_GEN" != "$LAST_GEN" ]; do
  echo "Waiting for index to update"
  sleep 5
  LAST_GEN=$(curl -s https://ebdmuir.github.io/helm-charts/index.yaml | yq -r '.generated')
done