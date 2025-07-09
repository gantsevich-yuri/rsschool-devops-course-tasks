## Task :heavy_exclamation_mark:

[Jenkins Installation and Configuration](https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/3_ci-configuration/task_4.md)

## Deploy :fast_forward:

**1 Deploy pod from Helm Chart with Nginx app**

nginx_values.yaml

```
service:
  type: NodePort
  ports:
    http: 80
    https: 443
  targetPort:
    http: http
    https: https
```

```
helm install my-nginx-v1 oci://registry-1.docker.io/bitnamicharts/nginx -f nginx_values.yaml
```

**2 Deploy pod from Helm Chart with Jenkins app**

```
helm repo add jenkinsci https://charts.jenkins.io
helm repo update
kubectl apply -f jenkins-01-volume.yaml                                                      # Set PV
kubectl apply -f jenkins-02-sa.yaml                                                          # Create Service Account
helm install jenkins -n jenkins --create-namespace -f jenkins-values.yaml jenkinsci/jenkins  # Install pod
```

**Usefull commands**
```
helm install [release-name] oci://registry-1.docker.io/bitnamicharts/nginx
helm install [release-name] oci://registry-1.docker.io/bitnamicharts/nginx -f [values.yaml]
helm list
helm get values [release-name]
helm uninstall [chart-name]

kubectl get pods
kubectl get svc
kubectl get nodes -A

minikube ip

helm list -n [namespace]
kubectl get pvc -n [namespace]
kubectl get events -n [namespace]--sort-by=.metadata.creationTimestamp
```

## Result :white_check_mark:

[Jenkins Installation and Configuration](https://github.com/gantsevich-yuri/rsschool-devops-course-tasks/pull/4)
