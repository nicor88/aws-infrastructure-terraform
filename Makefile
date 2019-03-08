REGION="us-east-1"
S3_REMOTE_STATE_BUCKET="nicola-corda-terraform"
STAGE="dev"
PROJECT="base"
MODULE =

init:
	@terraform init \
		-backend-config="region=$(REGION)" \
		-backend-config="bucket=$(S3_REMOTE_STATE_BUCKET)" \
		-backend-config="key=$(STAGE)/$(PROJECT)/state.tfstate"

plan:
	@terraform plan \
		-input=false \
		-refresh=true \
		-var-file=$(STAGE).tfvars

apply:
	@terraform apply \
		-input=false \
		-refresh=true \
		-var-file=$(STAGE).tfvars 

destroy:
	@terraform destroy --target module.$(MODULE) \
		-input=false \
		-refresh=true \
		-var-file=$(STAGE).tfvars

module_output:
	@terraform output -module=$(MODULE)
