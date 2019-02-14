# aws-infrastructure-terraform
AWS Infrastructure provisioned using Terraform

## Setup
Inside the file provider.tf comment the last section, 
regarding the backend then run 

```
terraform init
terraform apply
```

After that uncomment the backend section inside provider.tf, and run again
```
terraform init
```

## Notes
* Each time that you add a new model, you need to run
```
terraform init
```

## Outputs
To retrieve the outputs from a specific module run:
<pre>
terraform output -module=postgres
</pre>

## Resources
* [Use outputs between modules](https://github.com/hashicorp/terraform/issues/12466)
* [Examples](https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples)
