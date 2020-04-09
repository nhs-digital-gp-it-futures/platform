# Azure Terraform Setup

These folders contain the terraform for dev, test and prod.

To run them, access to the platform repo in Azure Devops is also required for the secrets access.

### Setup

To setup, [download and install terraform](https://www.terraform.io/downloads.html).

Then run `terraform init`.

### Plan

To test infrastructure changes, run the command below in the folder for the appropriate environment:

```bash
terraform plan -var-file=<PATH TO <ENV>-terraform.tfvars>  
```

### Execute

To apply infrastructure changes, run the command below in the folder for the appropriate environment:

```bash
terraform apply -var-file=<PATH TO <ENV>-terraform.tfvars>  
```

### Pipelines

Note that normally the changes are applied via pipeline.