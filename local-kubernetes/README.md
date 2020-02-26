# Local Kubernetes Development Environment

This folder contains the scripts necessary to run the entire environment locally. 

## Set Up Kubernetes

To begin, make sure you have kubernetes running locally as per the [Kubernetes Dev Setup Instructions](../Docs/DevSetup/local-k8s-setup.md)

Create the buying catalogue namespace - `kubectl apply -f local-namespace.yml`

To run the system, you need to create a secret in kubernetes to access the private container registry, as per the [Connect Local Kubernetes with our Private Container Registry Instructions](../Docs/DevSetup/k8s-private-registry.md).

You will also need a secret for the local instances of sql server - `kubectl create secret generic mssql --from-literal=SA_PASSWORD="<YOUR PASSWORD>" -n buyingcatalogue`. **Password must be follow this [policy](https://docs.microsoft.com/en-us/sql/relational-databases/security/password-policy?view=sql-server-ver15#password-complexity)**.

## Launching / Tearing Down the Environment

Then, run `launch-environment{.sh|ps1}` to launch the environment.

The script will start [all services available on these ports](#configuration-overview) on localhost

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
- Browse to [http://:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/)
- Click on Kubeconfig and select the “config” file under `C:\Users<Username>.kube\config`

## Working on a component locally

To run your own component in place:

- tear down the environment
- go to directory of the component you want to work on
- run launch-environment{.sh|ps1} from within that directory

## Configuration overview
| Service     | Port              |
| :-:         | :-:               |
| BAPI        | 5100              |
| BAPI-MSSQL  | 1450              |
| DAPI        | 5101              |
| AZURITE     | 10000,10001,10002 |
| MP          | 3002              |
| PB          | 3000              |
<!---
| ISAPI       | 5102              |
| ISAPI-MSSQL | 1451              |
-->
