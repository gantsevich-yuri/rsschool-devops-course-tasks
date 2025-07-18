## Task :heavy_exclamation_mark:

[Application Deployment via Jenkins Pipeline](https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/3_ci-configuration/task_6.md)

## Deploy :fast_forward:

**1 Start minikube**

```
minikube start
minikube status  # check minikube status
```

**2 Map docker.sock**

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

**4 Build docker image with App**

[Dockerfile](https://github.com/gantsevich-yuri/rsschool-devops-course-tasks/blob/task_6/deployment/my-app/Dockerfile)
```
docker build -t [tag] .
```

**5 SonarQube**

:heavy_check_mark: Example deploying SonarQube server in docker container from Ansible

[Ansible Playbook SonarQube](https://github.com/gantsevich-yuri/devops-learning/blob/main/sonarqube/ansible/playbook.yaml)

**6 Nexus Registry**

:heavy_check_mark: Example deploying Nexus server in docker container from Ansible

[Ansible Playbook Nexus](https://github.com/gantsevich-yuri/devops-learning/blob/main/nexus/ansible/playbook.yaml)

:heavy_exclamation_mark: By default docker push image to nexus by https.
If you want to push image by http protocol, you need set ip addr Nexus registry in "insecure-registries".

Example:

```
sudo mkdir -p /etc/systemd/system/docker.service.d/
sudo tee /etc/systemd/system/docker.service.d/override.conf <<EOF
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock --default-ulimit=nofile=1048576:1048576 --tlsverify --tlscacert /etc/docker/ca.pem --tlscert /etc/docker/server.pem --tlskey /etc/docker/server-key.pem --label provider=docker
EOF


sudo tee /etc/docker/daemon.json <<EOF
{
  "insecure-registries": ["158.160.55.161:8082"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "storage-driver": "overlay2"
}
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl status docker
```

**7 CI/CD Jenkins Pipeline**

[Pipeline](https://github.com/gantsevich-yuri/rsschool-devops-course-tasks/blob/task_6/deployment/Jenkinsfile)

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
