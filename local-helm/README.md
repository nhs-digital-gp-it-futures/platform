# Buying Catalogue Helm Charts

This directory contains helm charts for the buying catalogue, set up and intended to be run locally initially.

This process is designed to easily allow a developer to spin up the current environment, and easily work on component(s), while having the rest of the system in place.

## System Setup

The following steps are needed to be able to run the system successfully:

### Setup Kubernetes

To begin, make sure you have kubernetes running locally as per the [Kubernetes Dev Setup Instructions](../Docs/DevSetup/local-k8s-setup.md)

### Setup Namespace

Create the buying catalogue namespace - `kubectl apply -f local-namespace.yml`

### Setup Registry Secret

To run the system, you need to create a secret in kubernetes to access the private container registry, as per the [Connect Local Kubernetes with our Private Container Registry Instructions](../Docs/DevSetup/k8s-private-registry.md).

### Setup Helm

Note that this system relies upon helm charts. Instructions on how to install helm can be found [here](https://helm.sh/docs/intro/install/).

### (Optional) Run Dashboard

You may wish to run the dashboard. Instructions are [here](../Docs/DevSetup/run-dashboard.md).

## Launching, Updating the Environment

In order to launch or update the system to the latest built images or chosen config, simply run the appropriate launch script. It will run until torn down, even being restarted automatically once kubernetes is running again after a system restart.

#### Bash

```bash
./launch-or-update-environment.sh
```

#### PS

```Powershell
./launch-or-update-environment.ps1
```

The script will start [all services available on these ports](#configuration-overview) on localhost, or update them if they are running.

Ingress is also set up, so the front ends are exposed on localhost, as they would be when running in production.

Overrides in [local-overrides.yaml](local-overrides.yaml) can be set to choose whether to run a component in Kubernetes, or to consider it as running on the developers machine. When a service is disabled, anything that uses that service routes out to the developers machine, using `host.docker.internal`.

## Tearing Down the Environment

In order to tear down the system, simply run the appropriate tear down script.

#### Bash

```bash
.\tear-down-environment.sh
```

#### PS

```Powershell
.\tear-down-environment.ps1
```

## Configuration overview

|                             Service                              |       Port        |                           Ingress                           |
| :--------------------------------------------------------------: | :---------------: | :---------------------------------------------------------: |
|              [BAPI](http://localhost:5100/swagger)               |       5100        |                                                             |
|                            BAPI-MSSQL                            |       1450        |                                                             |
|              [DAPI](http://localhost:5101/swagger)               |       5101        |                                                             |
|                             AZURITE                              | 10000,10001,10002 |                                                             |
|              [ISAPI](http://localhost:5102/swagger)              |       5102        |             [ISAPI](http://localhost/identity)              |
|                            ISAPI-MSSQL                           |       1451        |                                                             |
| [MP](http://localhost:3002/supplier/solution/100000-001/preview) |       3002        | [MP](http://localhost/supplier/solution/100000-001/preview) |
|                   [PB](http://localhost:3000)                    |       3000        |                   [PB](http://localhost)                    |
