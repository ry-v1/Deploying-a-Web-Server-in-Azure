# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Getting Started
1. Clone this repository

2. Create your infrastructure as code

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions

1. Create and deploy a Policy

 - Create json file and define the policy

 <img width="720" alt="1  Create tag policy json" src="https://user-images.githubusercontent.com/72290009/188312957-432422d5-5cf0-419f-a6c4-b324a9d6e978.png">

 - Create tag policy definition 

 <img width="720" alt="2  Create tag policy definition" src="https://user-images.githubusercontent.com/72290009/188312967-00cf6e4c-1596-4cdf-8f9a-d546f7360a83.png">

 - Create tag policy assignment

 <img width="720" alt="3  Create tag policy assignment" src="https://user-images.githubusercontent.com/72290009/188312975-bcba6daa-6190-4d78-b62f-fe58e0b8304f.png">

 - List policy assignment

 <img width="720" alt="4  List policy assignment" src="https://user-images.githubusercontent.com/72290009/188312981-6d65288e-1fcb-47f4-b318-ea706648e054.png">

2. Deploying an Image using Packer
 
 - Deploying an Image using packer build command

 <img width="720" alt="5  Build Packer Image output-1" src="https://user-images.githubusercontent.com/72290009/188313285-7ddaa34e-1438-4536-bc81-bf01ce7785b8.png">

 <img width="720" alt="5  Build Packer Image output-2" src="https://user-images.githubusercontent.com/72290009/188313291-9750ee9a-ffd3-4ec5-8ca0-fe40e601cb3d.png">

3. Deploying Infrastructure using Terraform 

 - Define the desired infrastructure in main.tf 
 
 <img width="720" alt="6  main tf" src="https://user-images.githubusercontent.com/72290009/188313726-f60165fa-8b12-48c6-bc8e-a476e5de534e.png">
 
 - Define the variables in vars.tf

 <img width="720" alt="7  vars tf" src="https://user-images.githubusercontent.com/72290009/188313736-9df8ebef-c66f-4b7b-9e3e-94492bb43459.png">

 - Verify the infrastructure using "terraform plan"
 <img width="720" alt="8  terraform plan" src="https://user-images.githubusercontent.com/72290009/188315319-73ab6b5a-5dc6-42d4-acbe-9fcda4026303.png">

 - Create the infrastructure "terraform apply"
 
 For e.g use the variables defined var.tf in the command line to 
 
 ```bash
 
 terraform apply -var="vm_count=2" -var='vm_names=["dev", "test"]'
 
 ```

 <img width="720" alt="9 1 terraform apply" src="https://user-images.githubusercontent.com/72290009/188315509-c5cded40-fa29-4e07-a2e6-4afa750a7321.png">

 - After "terraform apply" resources are created in Azure
 
 <img width="720" alt="9 2 After terraform apply - resources in Azure" src="https://user-images.githubusercontent.com/72290009/188315514-44a0516f-2faf-46a3-8681-87ab69a0fefb.png">

 - Destroy the infrastructure "terraform destroy"

 <img width="720" alt="10 1 terraform apply" src="https://user-images.githubusercontent.com/72290009/188315523-a81b64dc-8209-4feb-9cef-347ab1313764.png">

 - After destroying, resources are deleted in Azure
 
 <img width="720" alt="10 2 After terraform destroy - resources in Azure" src="https://user-images.githubusercontent.com/72290009/188315544-b7ed07ea-f79e-4be1-8100-7b95c5a6a302.png">
