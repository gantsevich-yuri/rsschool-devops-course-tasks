## Task :heavy_exclamation_mark:

[Prometheus Deployment on K8s/minikube](https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/4_monitoring-configuration/task_7.md)

## Deploy :fast_forward:

**1 Start minikube**

```
minikube start
minikube status  # check minikube status
```

**2 Map docker.sock for Jenkins agent in minikube**

jenkins/jenkins-values.yaml
```
agent:
  image:
    repository: "jenkins/inbound-agent"
    tag: "3309.v27b_9314fd1a_4-6"
  volumes:
    - type: HostPath
      hostPath: /var/run/docker.sock
      mountPath: /var/run/docker.sock
```


**3 Start Jenkins server and agent**
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


**5 Prometheus**

//

**6 Nexus Registry**

//

**7 CI/CD Jenkins Pipeline**

[Pipeline](https://github.com/gantsevich-yuri/rsschool-devops-course-tasks/blob/task_7/deployment/Jenkinsfile)

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

[Simple Application Deployment with Helm](https://github.com/gantsevich-yuri/rsschool-devops-course-tasks/pull/7)
