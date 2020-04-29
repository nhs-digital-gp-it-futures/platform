# Selenium Grid

This directory contains the values and namespace spec to run Selenium Grid with 4 Chrome nodes.

This process is designed to easily allow a developer to spin up the grid for use with both Integration tests and Acceptance tests.

## System Setup

Instructions expect you to be in the seleniumGrid directory of the platform repository.
The following steps are needed to be able to run the system successfully:

### Setup Kubernetes

To begin, make sure you have kubernetes running locally as per the [Kubernetes Dev Setup Instructions](../Docs/DevSetup/local-k8s-setup.md)

### Setup Helm

Note that this system relies upon helm charts. Instructions on how to install helm can be found [here](https://helm.sh/docs/intro/install/).

### Add Namespace

Create the selenium grid namespace - `kubectl apply -f grid-namespace.yml`

## Launching, Updating the Environment

In order to launch or update the system to the latest built images or chosen config, simply run the appropriate launch script. It will run until torn down, even being restarted automatically once kubernetes is running again after a system restart.

#### Bash

```bash
./launch-selenium-grid.sh
```

#### PS

```Powershell
./launch-selenium-grid.ps1
```