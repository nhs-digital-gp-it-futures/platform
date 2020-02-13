# Platform

# Setting up Kubernetes for Dev locally 

## Windows

### Prerequisites

Have [Docker for Desktop](https://www.docker.com/products/docker-desktop) installed and running 

### How to
- Click on the Docker Desktop icon (in the System Tray) and click 'Settings'
- Click on the 'Kubernetes' setting on the left
- Click on 'Enable Kubernetes' and allow it to be installed

You can find a visual guide for reference [here](https://www.techrepublic.com/article/how-to-add-kubernetes-support-to-docker-desktop/) 

To verify the installation was sucessful, execute the following snippet from PowerShell
```
kubectl get nodes
```

If the response looks similar to this you are good to go
```
NAME             STATUS   ROLES    AGE    VERSION
docker-desktop   Ready    master   1m     v1.14.3
```

## Mac 

### Prerequisites

Have [Docker for Desktop](https://www.docker.com/products/docker-desktop) installed and running 

### How to
- Click on the Docker Desktop icon (in the macOS panel) and click Preferences
- Click the 'Kubernetes' tab
- Click on 'Enable Kubernetes' and allow it to be installed

You can find a visual guide for reference [here](https://www.techrepublic.com/article/how-to-add-kubernetes-support-to-docker-desktop/) 

To verify the installation was sucessful, execute the following snippet from terminal
```
kubectl get nodes
```

If the response looks similar to this you are good to go
```
NAME             STATUS   ROLES    AGE    VERSION
docker-desktop   Ready    master   1m     v1.14.3
```

## Linux 
To set up, please follow [this](https://kubernetes.io/docs/tasks/tools/install-minikube) tutorial

### Linux in a VM
run the `Linux_VM_Setup.sh` script located in the 'Setup' directory using bash as su

```
sudo bash ./Setup/Linux_VM_Setup.sh
```

