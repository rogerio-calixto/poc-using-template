# poc-using-template
poc-using-template

# init-branch
terraform init -reconfigure -backend-config=".\backend-config\dev.conf"

# update_templates
terraform get -update

# plan
terraform plan -var-file="config/local/terraform.tfvars" -out="tfplan.out"

# apply
terraform apply tfplan.out

# destroy
terraform destroy -var-file="config/local/terraform.tfvars" -auto-approve


# infra_costs
infracost breakdown --path=. --show-skipped --terraform-var-file dev.tfvars