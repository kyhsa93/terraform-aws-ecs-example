# Terraform example for AWS ECS

This is terraform example for AWS ECS.

In this project using Github actions for CI/CD pipe line.

If you create pull request in github, github actions run `terraform fmt` for check code format.

And then also run `terraform plan` for create execution plan.

If you merge pull request to main branch or push commit to main branch github actions run `terraform fmt` and `terraform plan` again and finally run `terraform apply` for apply your changed.

All secrets in this project using github repository's secrets.

If you want to use other secret stores(ex. AWS secrets manager, system manager, vault), you need to modify some code in container definition and github actions workflow.

The reason why using secrets by github, i just want use free function.

Container in this project use environment value though by terraform variables.

## Check list before using this
1. check your vpc and az.
2. check docker container image in container-definition.json
3. check environment value 
