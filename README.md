# RS School DevOps course :fire:

## [Task: K8s Cluster Configuration and Creation](https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/2_cluster-configuration/task_3.md)

**Use installing packages from terraform code (preferred) or manual installation:**

**Manual install k3s as master**
```
sudo curl -Lo /usr/local/bin/k3s https://github.com/k3s-io/k3s/releases/download/v1.26.5+k3s1/k3s; sudo chmod a+x /usr/local/bin/k3s
sudo k3s server &
sudo k3s kubectl get node
```

**Manual install k3s as worker**
```
sudo curl -Lo /usr/local/bin/k3s https://github.com/k3s-io/k3s/releases/download/v1.26.5+k3s1/k3s; sudo chmod a+x /usr/local/bin/k3s
# NODE_TOKEN comes from /var/lib/rancher/k3s/server/token on your server
sudo k3s agent \
  --server https://<MASTER_IP>:6443 \
  --token <NODE_TOKEN> &
```

**Manual install kubectl**
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
```

**Access to Kubernetes cluster from bastion**
- mkdir ~/.kube
- ssh <ip_k8s-master> 'sudo cat /etc/rancher/k3s/k3s.yaml' > ~/.kube/config_k3s
- ssh -fN -L 6443:<ip_k8s-master>:6443 username_k8s-master@ip_k8s-master    # set ssh tunnel
- KUBECONFIG=~/.kube/config_k3s kubectl get nodes

**Access to Kubernetes cluster from local machine**
- mkdir ~/.kube
- ssh -i <ssh_key> -J <username_bastion_host>@<ip_bastion_host> <username_k3s_master_node>@<ip_k3s_master_node> 'sudo cat /etc/rancher/k3s/k3s.yaml' > ~/.kube/config_k3s
- ssh -fN -L 6443:localhost:6443 -J <username_bastion>@<ip_bastion> <username_k3s_master_node>@<ip_k3s_master_node>   # set ssh tunnel
- KUBECONFIG=~/.kube/config_k3s kubectl get nodes

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
sudo k3s kubectl get nodes
sudo k3s kubectl get pods -A
sudo systemctl stop k3s
/usr/local/bin/k3s-uninstall.sh
```
