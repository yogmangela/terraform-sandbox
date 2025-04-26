# --------------------------------------------
# Variables
# --------------------------------------------

AWS_REGION ?= eu-west-2
CLUSTER_NAME ?= apollo-k8s-cluster
ACCOUNT_ID := $(shell aws sts get-caller-identity --query "Account" --output text)
ECR_REPO_NAME ?=inspect-sandbox
IMAGE_TAG ?=dev
ECR_URI := $(ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com/$(ECR_REPO_NAME)
IMAGE := $(ECR_URI):$(IMAGE_TAG)
NAMESPACE ?=inspect-sandbox

VENV_DIR ?= .venv   # <<<--- Add this
PROJECT_NAME ?=apollo-k8s-task   # <<<--- Your project folder name (where pyproject.toml is)

# --------------------------------------------
# show-vars
# --------------------------------------------
.PHONY: show-vars
show-vars:
	@echo "AWS_REGION  = $(AWS_REGION)"
	@echo "CLUSTER_NAME = $(CLUSTER_NAME)"
	@echo "ACCOUNT_ID  = $(ACCOUNT_ID)"
	@echo "ECR_REPO_NAME = $(ECR_REPO_NAME)"
	@echo "IMAGE_TAG   = $(IMAGE_TAG)"
	@echo "ECR_URI     = $(ECR_URI)"
	@echo "NAMESPACE   = $(NAMESPACE)"
# --------------------------------------------
# Virtual Environment Management
# --------------------------------------------

.PHONY: venv
venv:
	python3.13 -m venv .venv
	.venv/bin/pip install --upgrade pip
	.venv/bin/pip install inspect_ai==0.3.76
	.venv/bin/pip install git+https://github.com/UKGovernmentBEIS/inspect_k8s_sandbox.git@038794e9323a8e2db4bcebb7d54ba5f05fcd0b23


.PHONY: venv-clean
venv-clean:
	rm -rf .venv

# --------------------------------------------
# Docker
# --------------------------------------------
	
.PHONY: docker-build
docker-build:
	docker build -t $(ECR_REPO_NAME):$(IMAGE_TAG) .

.PHONY: docker-tag
	
docker-tag:
	echo "docker tag $(ECR_REPO_NAME):$(IMAGE_TAG) $(ECR_URI)"
	docker tag $(ECR_REPO_NAME):$(IMAGE_TAG) $(ECR_URI)

.PHONY: docker-push
docker-push: docker-tag
	aws ecr get-login-password --region $(AWS_REGION) | docker login --username AWS --password-stdin $(ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com
	docker push $(ECR_URI)
# --------------------------------------------
# Terraform
# --------------------------------------------

.PHONY: terraform-init
terraform-init:
	cd terraform && terraform init

.PHONY: terraform-apply
terraform-apply:
	cd terraform && terraform apply -auto-approve

.PHONY: terraform-destroy
terraform-destroy:
	cd terraform && terraform destroy -auto-approve

# --------------------------------------------
# Kubernetes
# --------------------------------------------

.PHONY: k8s-deploy
k8s-deploy:
	kubectl apply -f k8s/deployment.yaml

# .PHONY: k8s-delete
# k8s-delete:
# 	kubectl delete -f k8s/deployment.yaml

# --------------------------------------------
# Full Shortcuts
# --------------------------------------------

.PHONY: all
all: venv docker-build docker-push terraform-init terraform-apply k8s-deploy

.PHONY: clean
clean: venv-clean terraform-destroy k8s-delete