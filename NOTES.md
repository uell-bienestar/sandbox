# E2E Research

## docker
Download [here](https://hub.docker.com/editions/community/docker-ce-desktop-mac)

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
### Alias kubectl
In `~/.zshrc` add:
```shell
alias kubectl='minikube kubectl --'
```
### Set VirtualBox as default driver for MacOS
```shell
minikube config set driver virtualbox
```
### Mount local folder as shared folder
*This is a running process.*
```shell
minikub mount ./:/etc/security
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
minikube dashboard
```
### Run tunnel for LoadBalancer
*This is a running process.*
```shell
minikube tunnel
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

## kompose
### Install
```shell
curl -L https://github.com/kubernetes/kompose/releases/download/v1.26.0/kompose-darwin-amd64 -o kompose
chmod +x kompose
sudo mv kompose /usr/local/bin/kompose
```

### Known Issues
#### Virtualbox is not visible in minikube
> Exiting due to IF_VBOX_NOT_VISIBLE: Failed to start host: creating host: create: creating: Error setting up host only network on machine start: The host-only adapter we just created is not visible. This is a well known VirtualBox bug. You might want to uninstall it and reinstall at least version 5.0.12 that is is supposed to fix this issue

To fix this issue, please go to System Preferences > Security & Privacy > Allow > Then allow Oracle
