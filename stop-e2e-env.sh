#!/bin/bash

echo "Stopping mount..."
kill $(ps aux | grep -E 'minikube\smount' | awk '{print $2}')
echo "Stopping tunnel"
kill $(ps aux | grep -E 'minikube\stunnel\s\-c' | awk '{print $2}')
echo "Quitting dashboard"
kill $(ps aux | grep -E 'minikube\sdashboard' | awk '{print $2}')

echo "Stopping minikube..."
minikube delete

echo "Finished"
