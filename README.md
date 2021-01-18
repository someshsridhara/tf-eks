# tf-eks

> Terraform code to create an EKS cluster and it's dependent infrastructure components

## Prerequisites
1. Terraform: v0.14.2 or above
2. Go lang: v1.15.x

## To run tests
In the directory `test` run the following,
1. terraform init
2. terraform workspace new test
3. go mod init tf_eks_unit_test.go
4. go test -v tf_eks_unit_test.go copy.go -timeout=60m

## To plan and apply
In the root of the project `tf-eks`
1. terraform init
2. terraform workspace new dev
3. terraform plan -out=dev.tfplan
4. terraform apply dev.tfplan