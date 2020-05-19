#!/bin/bash

set -e

ENV='dev'
NAMESPACE='buyingcatalogue-dev'
ISPRIVATE=0
declare -a PRIVATECOMPONENTS=("BuyingCatalogueService" "DocumentService" "MarketingPage" "PublicBrowse")

print_usage() {
  printf "
	This script iterates through the subdirectories of 'Kubernetes' directory and
	performs a 'kubectl apply -f {\$ENV-*.manifest.yml} -n \$NAMESPACE' command in each one.
  
	Usage:
	
	-e) accepts a string representing the environmental prefix of manifest files.
	Eg: dev | test | prod, defaults to: $ENV
	
	-n) accepts a string representing the namespace to which should the manifest file be applied to.
	defaults to: $NAMESPACE
	
	-p) [optional] deploy only to private. Not true by default.
  "
}

while getopts "pe:n:" flag; do
  case "${flag}" in
  	p) ISPRIVATE=1 ;;
    e) ENV="${OPTARG}" ;;
	n) NAMESPACE="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done


if [[ $ISPRIVATE -eq 1 ]]; then
	for component in "${PRIVATECOMPONENTS[@]}"; do
		for file in Kubernetes/"$component"/$ENV-*; do
			if [[ -f $file ]]; then
				kubectl apply -f $file -n $NAMESPACE
			fi
		done
	done
	exit 1
fi

shopt -s extglob
# iterate through all subdirectories apart from 'Namespace' subdirectory
for dir in Kubernetes/!(Namespace); do
    for file in "$dir"/$ENV-*; do
        if [[ -f $file ]]; then
            kubectl apply -f $file -n $NAMESPACE
        fi
    done
done
