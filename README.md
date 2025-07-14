## Task :heavy_exclamation_mark:

[Application Deployment via Jenkins Pipeline](https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/3_ci-configuration/task_6.md)

## Deploy :fast_forward:

**1 Start minikube**

```
minikube start
minikube status  # check minikube status
```

**2 Jenkins**
```
helm repo add jenkinsci https://charts.jenkins.io
helm repo update

minikube ssh
sudo mkdir -p /data/jenkins-volume/
sudo chown -R 1000:1000 /data/jenkins-volume/ 

kubectl create namespace jenkins
kubectl apply -f jenkins/jenkins-01-volume.yaml                                   # Set PV
kubectl apply -f jenkins/jenkins-02-sa.yaml                                       # Create Service Account
helm install jenkins -n jenkins -f jenkins/jenkins-values.yaml jenkinsci/jenkins  # Install pod

```

**3 SonarQube**
```
install and deploy from Helm
```

**4 Nexus Registry**
```
install and deploy from Helm
```

**5 CI/CD Pipline**
```
install pipline
```

**6 Check Deployment**
```
helm install python-app -n my-app-space --create-namespace ./my-chart
```


**Usefull commands**
```
helm install [release-name] -n [namespace] [chartname]
helm list
helm get values [release-name]
helm uninstall [chart-name]

kubectl get pods
kubectl get svc
kubectl get nodes -A

minikube ip

helm list -n [namespace]
kubectl get pvc -n [namespace]
kubectl get events -n [namespace] --sort-by=.metadata.creationTimestamp
```

## Result :white_check_mark:

[Simple Application Deployment with Helm](https://github.com/gantsevich-yuri/rsschool-devops-course-tasks/pull/6)
