# aws-infrastructure-terraform
AWS Infrastructure provisioned using Terraform

## Requirements
* Install terraform
* Configure your aws credentials
* Setup the environenment variable `export AWS_PROFILE=your_profile`
* Run `cp tfvars.dist dev.tfvars``
* S3 Bucket manually created to use as Terraform backend

## Setup
Add the S3 bucket inside the Makefile and inside `dev.tfvars`. The init the project running:
```
make init
```

## Plan
```
make plan
```

## Apply
```
make apply
```

## Modules

Each time that you add a new module, you need to run
```
make init
```

### Destroy Single Module
<pre>
make destroy MODULE=postgres_example
</pre>

### Outputs
To retrieve the outputs from a specific module run:
<pre>
make module_output MODULE=postgres_example
</pre>

## Resources
* [Use outputs between modules](https://github.com/hashicorp/terraform/issues/12466)
* [Examples](https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples)
