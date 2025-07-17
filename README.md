## Task :heavy_exclamation_mark:

[Application Deployment via Jenkins Pipeline](https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/3_ci-configuration/task_6.md)

## Deploy :fast_forward:

**1 Start minikube**

```
minikube start
minikube status  # check minikube status
```

**2 Build docker image for jenkins agent pod in minikube cluster**

```
FROM jenkins/inbound-agent:3309.v27b_9314fd1a_4-6

USER root
RUN apt-get update && apt-get install -y docker.io && rm -rf /var/lib/apt/lists/*
USER jenkins
```

build image in minikube cluster
```
eval $(minikube docker-env)
docker build -t  jenkins/inbound-agent:3309.v27b_9314fd1a_4-6_with_docker_python .
docker images
eval $(minikube docker-env -u)
```

**3 Map docker.sock and use new jenkins image**
jenkins/jenkins-values.yaml
```
agent:
  image:
    repository: "jenkins/inbound-agent"
    tag: "3309.v27b_9314fd1a_4-6_with_docker_python"
  volumes:
    - type: HostPath
      hostPath: /var/run/docker.sock
      mountPath: /var/run/docker.sock
```

**4 Start Jenkins**
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

**5 SonarQube**

External Server

**6 Nexus Registry**

External Server


**7 CI/CD Pipline**
```
install pipline
```

**8 Check Deployment**

Check

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
