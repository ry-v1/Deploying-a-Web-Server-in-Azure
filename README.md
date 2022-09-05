# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Project overview
In this project, we will use Packer and a Terraform to deploy a customizable, scalable web server in Azure.

The project will consist of the following main steps:

 - Creating a Packer template
 - Creating a Terraform template
 - Deploying the infrastructure
 - Creating documentation in the form of a README

 #### Customizing variables.tf file
 
 Variable blocks have three optional arguments.

 1. Description: A short description to document the purpose of the variable.
 2. Type: The type of data contained in the variable.
 3. Default: The default value.

 For example a variable name "prefix" can be defined as below
 
 ```tf
 
 variable "vm_names"{
   description = "Enter the names of virtual machines to be created"
   type = list
   default = ["dev", "test", "prod"]
   
```

We can use variable in main.tf as below.

```tf
resource "azurerm_linux_virtual_machine" "main" {
  count = var.vm_count

  name                            = "${var.prefix}-vm-${var.vm_names[count.index]}"
  resource_group_name             = data.azurerm_resource_group.main.name
  location                        = data.azurerm_resource_group.main.location
  ...
```   
  
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

 <img width="1440" alt="image" src="https://user-images.githubusercontent.com/72290009/188371082-0d161efc-e6b3-4d28-ab98-45347b34b5fc.png">

 - Create tag policy definition 

 <img width="1440" alt="image" src="https://user-images.githubusercontent.com/72290009/188371274-fa681e11-7016-47b2-834d-6e3fcbc3a358.png">

 - Create tag policy assignment

 <img width="1440" alt="image" src="https://user-images.githubusercontent.com/72290009/188371372-fbf6aa9d-d3b5-4dcd-a1e7-acad3ae8f207.png">

 - List policy assignment

 <img width="1440" alt="image" src="https://user-images.githubusercontent.com/72290009/188371555-93063b74-0918-4734-8a94-e8bea3fbce71.png">


2. Deploying an Image using Packer
 
 - Deploying an Image using packer build command

 ```bash
 
 packer build server.json

 
 ```

 <img width="1440" alt="image" src="https://user-images.githubusercontent.com/72290009/188383697-2e7e22bd-10e3-48d2-a4f5-ae0e2b43e228.png">

 <img width="1440" alt="image" src="https://user-images.githubusercontent.com/72290009/188384336-77d8e062-9531-4359-966b-c2efa3b5f28e.png">


3. Deploying Infrastructure using Terraform 

 - Define the desired infrastructure in main.tf 
 
 <img width="1440" alt="image" src="https://user-images.githubusercontent.com/72290009/188384596-1f3664c1-d713-4292-a348-c4ff93c24bb7.png">

 - Define the variables in vars.tf

 <img width="1440" alt="image" src="https://user-images.githubusercontent.com/72290009/188384820-83af8daa-7f88-43c1-a419-09cfb192a684.png">

 - Verify the infrastructure using "terraform plan"
 
 ```bash
 
 terraform plan -out solution.plan
 
 ```
 
 <img width="1440" alt="image" src="https://user-images.githubusercontent.com/72290009/188388091-c7778b86-302b-4c0d-9af6-01cd950fd2b1.png">

 
 - Create the infrastructure "terraform apply"
 
 For e.g use the variables defined variables.tf in the command line to 
 
 ```bash
 
 terraform apply -var="vm_count=2" -var='vm_names=["dev", "test"]'
 
 ```

 <img width="1440" alt="image" src="https://user-images.githubusercontent.com/72290009/188388670-79175631-05bd-4614-a843-572fa6196b6a.png">

 <img width="1440" alt="image" src="https://user-images.githubusercontent.com/72290009/188389246-fa1fd050-8827-431f-81cc-d6a49da98c89.png">

 
 - After "terraform apply" resources are created in Azure
 
 <img width="1440" alt="image" src="https://user-images.githubusercontent.com/72290009/188390121-f1a4d509-f8c6-42df-9278-32185b4bce18.png">

 - Destroy the infrastructure "terraform destroy"
 
 <img width="1440" alt="image" src="https://user-images.githubusercontent.com/72290009/188391838-7bee4915-912f-4cff-91c8-4d95b71da280.png">

 - After destroying, resources are deleted in Azure
 
 <img width="1440" alt="image" src="https://user-images.githubusercontent.com/72290009/188392493-32e6735a-f004-420d-974d-8ebb4da05cec.png">

