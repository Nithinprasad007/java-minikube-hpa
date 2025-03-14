Java Minikube HPA

This project demonstrates how to deploy a Java-based application on Minikube with Horizontal Pod Autoscaling (HPA). It includes setting up Minikube, deploying the application, enabling HPA, and performing load testing to verify autoscaling.

Prerequisites

Before running the project, ensure you have the following installed:

Minikube - Installation Guide

Kubectl - Installation Guide

Docker - Installation Guide

Hey (Load Testing Tool) - Installation Guide

Setup Instructions

1. Start Minikube

minikube start --cpus=4 --memory=4g

2. Enable Metrics Server

minikube addons enable metrics-server

3. Clone the Repository

git clone https://github.com/Nithinprasad007/java-minikube-hpa.git
cd java-minikube-hpa

4. Build and Push Docker Image

Replace <your-dockerhub-username> with your actual Docker Hub username.

docker build -t <your-dockerhub-username>/hello-world-java .
docker login
docker push <your-dockerhub-username>/hello-world-java

5. Update Deployment File

Edit deployment.yaml and replace the image name with your actual Docker Hub repository:

        image: <your-dockerhub-username>/hello-world-java

6. Deploy Application to Minikube

kubectl apply -f deployment.yaml

7. Verify Deployment

kubectl get pods
kubectl get svc

8. Enable Horizontal Pod Autoscaler (HPA)

kubectl autoscale deployment hello-world --cpu-percent=50 --min=1 --max=5

9. Load Testing (Trigger Scaling)

Run a load test that gradually increases the load on the application.

hey -z 60s -c 100 http://$(minikube service hello-world-service --url)

10. Monitor Scaling

kubectl get hpa --watch
kubectl get pods --watch

11. Cleanup

To stop all services, delete pods, and remove images:

kubectl delete -f deployment.yaml
kubectl delete hpa hello-world
minikube delete

References

Minikube: https://minikube.sigs.k8s.io/docs/

Kubectl: https://kubernetes.io/docs/reference/kubectl/overview/

Docker: https://docs.docker.com/

Hey Load Testing Tool: https://github.com/rakyll/hey

