# Task 2: Basic Infrastructure Configuration

## Objective

In this task, you will write Terraform code to configure the basic networking infrastructure required for a Kubernetes (K8s) cluster.

## Steps

1. **Write Terraform Code**

   - Create Terraform code to configure the following:
     - VPC
     - 2 public subnets in different AZs
     - 2 private subnets in different AZs
     - Internet Gateway
     - Routing configuration:
       - Instances in all subnets can reach each other
       - Instances in public subnets can reach addresses outside VPC and vice-versa

2. **Organize Code**

   - Define variables in a separate variables file.
   - Separate resources into different files for better organization.

3. **Verify Configuration**

   - Execute `terraform plan` to ensure the configuration is correct.
   - Provide a resource map screenshot (VPC -> Your VPCs -> your_VPC_name -> Resource map).

4. **Additional Tasks💫**
   - Implement security groups.
   - Create a bastion host for secure access to the private subnets.
   - Organize NAT for private subnets, so instances in the private subnet can connect with the outside world:
     - Simpler way: create a NAT Gateway
     - Cheaper way: configure a NAT instance in the public subnet
   - Document the infrastructure setup and usage in a README file.

**Run code**
```
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```
**Connect to Bastion Host**
```
ssh -i ~/.ssh/your_key.pem username@bastion_public_ip
```
## Author

This project is part of the [RS School DevOps Course](https://github.com/rolling-scopes-school/tasks/tree/master/devops) :fire:

Task by: [@gantsevich-yuri](https://github.com/gantsevich-yuri)
