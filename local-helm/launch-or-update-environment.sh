#!/bin/bash

helm upgrade bc buyingcatalogue -n buyingcatalogue -i -f environments/local-docker.yaml -f local-overrides.yaml $@