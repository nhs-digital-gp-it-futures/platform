#!/bin/bash


# Usage: Comment out the components you are working on
kubectl apply -f local-sql-kubernetes-manifest.yml
#kubectl apply -f local-bapi-kubernetes-manifest.yml
kubectl apply -f local-azurite-kubernetes-manifest.yml
kubectl apply -f local-dapi-kubernetes-manifest.yml
kubectl apply -f local-marketingpage-kubernetes-manifest.yml
kubectl apply -f local-publicbrowse-kubernetes-manifest.yml
