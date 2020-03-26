# Running the dashboard

You may wish to use the dashboard to view what is happening in Kubernetes (instructions below from [collabnix.com](https://collabnix.com/kubernetes-dashboard-on-docker-desktop-for-windows-2-0-0-3-in-2-minutes/))
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
- Run the proxy - `kubectl proxy` (**will take over terminal**)
- Browse to [http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/)
- Click on Kubeconfig and select the “config” file under `C:\Users<Username>.kube\config`