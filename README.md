# RS School DevOps course :fire:

## Task
[K8s Cluster Configuration and Creation](https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/2_cluster-configuration/task_3.md)

**Deploy pod with Nginx app**
```
kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml
```
**or Nginx + Services:**

nginx-pod.yaml 
```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80
```

nginx-service.yaml
```
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 80        
    targetPort: 80  
    nodePort: 30080
```

**Usefull commands**
```
kubectl get nodes
kubectl get pods -A
```

## Result
[K8s Cluster Configuration and Creation in AWS](https://github.com/gantsevich-yuri/rsschool-devops-course-tasks/pull/3)
