#!/bin/bash

# This script packages up the helm charts and updates the index

for chart in $(ls charts/); do
  helm package charts/$chart
  # echo $chart
done

helm repo index --url https://ebdmuir.github.io/helm-charts/ .