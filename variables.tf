variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default = "UdacityDS"  
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default = "East US"  
}

variable "username"{
  description = "User name for all resources in this example should be created."
  default = "username"
}

variable "password"{
  description = "Password all resources in this example should be created."
  default= "Pa$$w0rd"
}

variable "packerImageId"{
  default = "/subscriptions/fbf787c1-ed83-44ad-946e-6ff3b027c400/resourceGroups/Azuredevops/providers/Microsoft.Compute/images/myPackerImage"
}

variable "vm_count"{
  description = "Enter the number of virtual machines to be created"
  type = number
  default = 3
}

variable "vm_names"{
  description = "Enter the names of virtual machines to be created"
  type = list
  default = ["dev", "test", "prod"]
}
