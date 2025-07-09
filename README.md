## Task :heavy_exclamation_mark:

[Simple Application Deployment with Helm](https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/3_ci-configuration/task_5.md)

## Deploy :fast_forward:

**1 Docker artifact**
```
docker build -t my-python-app:v1.1.1 .
```

```
docker run -it --rm my-python-app:v1.1.1 /bin/bash     # run and check container
```

**2 Push image to minikube registry**
```
minikube image load my-python-app:v1.1.1
minikube ssh -- docker images     # Check images
```

**3 Check Helm Chart**
```
helm template my-python-app ./my-chart/
```

**2 Deploy the Application**
```
helm install python-app -n my-app-space --create-namespace ./my-chart
```

**3 Store Artifacts in Git**

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

[Simple Application Deployment with Helm](https://github.com/gantsevich-yuri/rsschool-devops-course-tasks/pull/4)
