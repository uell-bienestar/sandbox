# E2E Research

## Local
### No Password Sudoers
*You may need to start new terminal sessions to see the changes.*
```shell
sudo visudo
```
```shell
# /etc/sudoers

%admin ALL=(ALL) NOPASSWD: ALL
```
### Append hosts to /etc/hosts
```shell
sudo cat hosts >> /etc/hosts
```

## virtualbox
```shell
brew install virtualbox
```

## minikube
See [minikube documentation](https://minikube.sigs.k8s.io/docs/start/)
### Install
```shell
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
sudo install minikube-darwin-amd64 /usr/local/bin/minikube
rm minikube-darwin-amd64
```
### Increase resources
```shell
minikube start --memory 8192 --cpus 4
# or
minikube config set cpus 4
minikube config set memory 8192
```
### Alias kubectl
```shell
# ~/.zshrc

alias kubectl='minikube kubectl --'
```
### Set VirtualBox as default driver for MacOS
```shell
minikube config set driver virtualbox
```
### Set /etc/hosts
```shell
cp -r .minikube/files/etc ~/.minikube/files
minikube start
```
### Mount local folder as shared folder
*This is a background process.*
```shell
minikube mount ./:/etc/security &> /dev/null & #MOUNT_PID=$!
```
### Kill Mount
*This is a background process.*
```shell
kill $(ps aux | grep -E "minikube\smount" | awk '{print $2}')
#kill $MOUNT_PID
```
### Interact with cluster
```shell
kubectl get po -A
```
or
```shell
minikube kubectl -- get po -A
```
### View Dashboard
*This is a running process.*
```shell
minikube dashboard &> /dev/null & #DASHBOARD_PID=$!
```
### Kill Dashboard
```shell
kill $(ps aux | grep -E "minikube\sdashboard" | awk '{print $2}')
#kill $DASHBOARD_PID
```
### Run tunnel for LoadBalancer
*This is a background process.*
```shell
minikube tunnel &> /dev/null & #TUNNEL_PID=$!
```
### Kill tunnel
```shell
kill $(ps aux | grep -E "minikube\stunnel\s\-c" | awk '{print $2}')
#kill $TUNNEL_PID
```
### Start minikube
```shell
minikube start
```
### Stop minikube
```shell
minikube stop
```
### Delete all minikube clusters
```shell
minikube delete --all
```
### Wait for kubernetes pod to be ready in deployment
```shell
kubectl wait --for=condition=ready pod $(kubectl get pods | grep keycloak | awk '{print $1}')
```
### Apply kubernetes deployment
```shell
kubectl apply -f ./komposed/keycloak-service.yaml \
-f ./komposed/keycloak-deployment.yaml \
-f ./komposed/logica-sandbox-volume-persistentvolumeclaim.yaml \
-f ./komposed/sandbox-mysql-deployment.yaml \
-f ./komposed/sandbox-mysql-service.yaml \
-f ./komposed/sandbox-manager-api-deployment.yaml \
-f ./komposed/sandbox-manager-api-service.yaml \
-f ./komposed/sandbox-deployment.yaml \
-f ./komposed/sandbox-service.yaml \
-f ./komposed/static-content-deployment.yaml \
-f ./komposed/static-content-service.yaml
```

## kompose
### Install
```shell
curl -L https://github.com/kubernetes/kompose/releases/download/v1.26.0/kompose-darwin-amd64 -o kompose
chmod +x kompose
sudo mv kompose /usr/local/bin/kompose
```

## MySQL
### Connect to database
```shell
mysql -u root -ppassword -h 10.96.0.1 -P 3306
```

### Known Issues
#### Virtualbox is not visible in minikube
> Exiting due to IF_VBOX_NOT_VISIBLE: Failed to start host: creating host: create: creating: Error setting up host only network on machine start: The host-only adapter we just created is not visible. This is a well known VirtualBox bug. You might want to uninstall it and reinstall at least version 5.0.12 that is is supposed to fix this issue

To fix this issue, please go to System Preferences > Security & Privacy > Allow > Then allow Oracle
