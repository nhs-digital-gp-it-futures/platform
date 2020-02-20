# Local Kubernetes Development Environment

This folder contains the scripts necessary to run the entire environment locally. 

## Set Up Kubernetes

To begin, make sure you have kubernetes running locally as per the [Kubernetes Dev Setup Instructions](../Docs/DevSetup/local-k8s-setup.md)

Create the buying catalogue namespace - `kubectl apply -f local-namespace.yml`

To run the system, you need to create a secret in kubernetes to access the private container registry, as per the [Connect Local Kubernetes with our Private Container Registry Instructions](../Docs/DevSetup/k8s-private-registry.md).

You will also need a secret for the local instances of sql server - `kubectl create secret generic mssql --from-literal=SA_PASSWORD="<YOUR PASSWORD>" -n buyingcatalogue`. **Password must be 8 characters**.

## Launching / Tearing Down the Environment

Then, run `launch-environment{.sh|ps1}` to launch the environment.
The script will start, available on localhost:
- Document Service
  - [DAPI](http://localhost:5101/swagger) on port 5101 
  - Azurite on ports 10000 (blob),10001 (queue),10002 (table), with development user default (access with [Azure Storage Explorer](https://azure.microsoft.com/en-gb/features/storage-explorer/))
- Buying Catalogue Service
  - [BAPI](http://localhost:5100/swagger) on port
  - SQL Server on port 1450 (log in localhost,1450 in [SSMS](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15))
- [Marketing Pages](http://localhost:3002/supplier/solution/100000-001/preview) on port 3002
- [Public Browse](http://localhost:3000/) on port 3000

Run `tear-down-environment{.sh|ps1}` to tear down the environment.

## Running the dashboard

You may also wish to use the dashboard to view what is happening in Kubernetes (instructions below from [collabnix.com](https://collabnix.com/kubernetes-dashboard-on-docker-desktop-for-windows-2-0-0-3-in-2-minutes/))
- Apply the dashboard yaml - `kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml`
- Set up the access token:
#### Powershell
```Powershell
$TOKEN=((kubectl -n kube-system describe secret default | Select-String "token:") -split " +")[1]
kubectl config set-credentials docker-desktop --token="${TOKEN}"
```
#### Bash
```bash
TOKEN=`kubectl -n kube-system describe secret default | grep token: | awk '{print $2}'`
kubectl config set-credentials docker-desktop --token=$TOKEN
```
- Run the proxy - `kubectl proxy`
- Browse to [http://:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/](http://:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/)
- Click on Kubeconfig and select the “config” file under `C:\Users<Username>.kube\config`

## Running Own Component

To run your own component in place:

- tear down the environment;
- comment out the component from the launch script;
- replace the name of the component with `host.docker.internal` in any config where required in any other component;
- launch the environment.