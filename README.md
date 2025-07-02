## Task :heavy_exclamation_mark:

[Jenkins Installation and Configuration](https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/3_ci-configuration/task_4.md)

## Deploy :fast_forward:

**Deploy pod from Helm Chart with Nginx app**

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

**Usefull commands**
```
helm install <release-name>> oci://registry-1.docker.io/bitnamicharts/nginx
helm install <release-name>> oci://registry-1.docker.io/bitnamicharts/nginx -f <values.yaml>
helm list
helm get values <release-name>
helm uninstall <chart-name>

kubectl get pods
kubectl get svc
kubectl get nodes -A

minikube ip
```

## Result :white_check_mark:

[Jenkins Installation and Configuration](https://github.com/gantsevich-yuri/rsschool-devops-course-tasks/pull/3)
