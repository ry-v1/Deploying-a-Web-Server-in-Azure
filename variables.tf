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
  default = "/subscriptions/4e780871-9657-43bf-b521-9c73706b76b1/resourceGroups/Azuredevops/providers/Microsoft.Compute/images/myPackerImage"
}

variable "vm_count"{
  type = number
  default = 1
}

variable "vm_names"{
  type = list
  default = ["test"]
}
