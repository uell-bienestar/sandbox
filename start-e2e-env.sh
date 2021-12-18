#!/bin/bash

# Start k8s cluster
minikube start
minikube mount ./:/etc/security &> /dev/null &
minikube tunnel -c &> /dev/null &
minikube dashboard &> /dev/null &

# Deploy keycloak and mysql to cluster
kubectl apply -f ./komposed/keycloak-service.yaml \
-f ./komposed/keycloak-deployment.yaml \
-f ./komposed/logica-sandbox-volume-persistentvolumeclaim.yaml \
-f ./komposed/sandbox-mysql-deployment.yaml \
-f ./komposed/sandbox-mysql-service.yaml

# Wait for pods to be ready
kubectl wait deploy/keycloak --for=condition=available --timeout=2m
kubectl wait deploy/sandbox-mysql --for=condition=available --timeout=2m
kubectl wait --for=condition=ready --timeout=2m pod "$(kubectl get pods | grep sandbox-mysql | awk '{print $1}')"
kubectl wait --for=condition=ready --timeout=2m pod "$(kubectl get pods | grep keycloak | awk '{print $1}')"

kubectl apply -f ./komposed/sandbox-manager-api-deployment.yaml \
-f ./komposed/sandbox-manager-api-service.yaml \
-f ./komposed/static-content-deployment.yaml \
-f ./komposed/static-content-service.yaml \
-f ./komposed/sandbox-deployment.yaml \
-f ./komposed/sandbox-service.yaml \
-f ./komposed/patient-data-manager-deployment.yaml \
-f ./komposed/patient-data-manager-service.yaml \
-f ./komposed/dstu2-deployment.yaml \
-f ./komposed/dstu2-service.yaml \
-f ./komposed/r4-deployment.yaml \
-f ./komposed/r4-service.yaml \
-f ./komposed/r5-deployment.yaml \
-f ./komposed/r5-service.yaml \
-f ./komposed/stu3-deployment.yaml \
-f ./komposed/stu3-service.yaml \
-f ./komposed/bilirubin-risk-chart-deployment.yaml \
-f ./komposed/bilirubin-risk-chart-service.yaml
