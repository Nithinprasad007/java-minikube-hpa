# Java Minikube HPA Setup

This project demonstrates how to deploy a Java application in Minikube with Horizontal Pod Autoscaler (HPA). The application automatically scales between 1 to 5 pods based on CPU usage.

## Prerequisites

Ensure you have the following installed:

- [Docker](https://docs.docker.com/engine/install/ubuntu/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
- [Metrics Server](https://github.com/kubernetes-sigs/metrics-server)
- [Hey (Load Testing Tool)](https://github.com/rakyll/hey)

## Steps to Run the Project

```sh
# 1. Start Minikube
minikube start

# 2. Enable Metrics Server
minikube addons enable metrics-server

# 3. Build and Push Docker Image  
# Replace <your-dockerhub-username> with your actual Docker Hub username.
docker build -t <your-dockerhub-username>/hello-world-java .
docker push <your-dockerhub-username>/hello-world-java

# 4. Edit deployment.yaml  
# Update the image field inside deployment.yaml to use your Docker Hub username.
# Open the file and update:
# containers:
# - name: hello-world
#   image: <your-dockerhub-username>/hello-world-java

# 5. Deploy Application to Minikube
kubectl apply -f deployment.yaml

# 6. Verify Pods and Services
kubectl get pods
kubectl get svc

# 7. Enable Horizontal Pod Autoscaler (HPA)
kubectl autoscale deployment hello-world --cpu-percent=50 --min=1 --max=5

# 8. Check HPA Status
kubectl get hpa

# 9. Load Test to Scale Pods  
# This command will gradually increase the load on the service.
hey -z 60s -c 100 http://$(minikube service hello-world-service --url)

# 10. Monitor Scaling in Real-time
kubectl get hpa --watch
kubectl get pods --watch

# 11. Stop and Cleanup
kubectl delete deployment hello-world
kubectl delete service hello-world-service
kubectl delete hpa hello-world
minikube delete

# 13. References  
# Kubernetes Docs: https://kubernetes.io/docs/
# Minikube Docs: https://minikube.sigs.k8s.io/docs/
# HPA: https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/
# Docker Hub: https://hub.docker.com/
# Metrics Server: https://github.com/kubernetes-sigs/metrics-server
# Hey Load Testing Tool: https://github.com/rakyll/hey
