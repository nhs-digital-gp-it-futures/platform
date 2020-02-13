#!/bin/bash

#get kubectl
# v1.14.3 to be consistent with what docker desktop installs
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.14.3/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

username=$(eval "cmd.exe /c echo %username%")
ln -s /mnt/c/Users/$username/.kube ~/.kube
kubectl config use-context docker-for-desktop