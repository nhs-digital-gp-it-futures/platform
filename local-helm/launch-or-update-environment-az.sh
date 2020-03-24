#!/bin/bash

helm upgrade bc buyingcatalogue -n buyingcatalogue -i -f environments/remote-azure.yaml -f az-overrides.yaml --wait $@

kubectl port-forward svc/gpitfutures-bc-bapi-sql 1450:1450 -n buyingcatalogue &
kubectl port-forward svc/gpitfutures-bc-isapi-sql 1451:1451 -n buyingcatalogue &
#kubectl port-forward svc/gpitfutures-bc-mp 3002:3002 -n buyingcatalogue &
kubectl port-forward svc/gpitfutures-bc-pb 3000:3000 -n buyingcatalogue &
kubectl port-forward svc/gpitfutures-bc-isapi 5102:5102 -n buyingcatalogue &
wait