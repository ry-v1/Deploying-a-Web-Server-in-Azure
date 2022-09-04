terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.21.1"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "XXXXX"
  tenant_id       = "XXXX"
}

# Create/Reuse a Resource Group.
data "azurerm_resource_group" "main" {
  name     = "Azuredevops"
}

# Create a Virtual network and a subnet on that virtual network.
resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/22"]
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create a Network Security Group. 
# Ensure that you explicitly allow access to other VMs on the subnet 
# and deny direct access from the internet.

resource "azurerm_network_security_group" "main" {
  name                = "${var.prefix}-nsg"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  security_rule {
    name                       = "AllowSubnetInBound"
    description                = "Allow access to other VMs on the subnet"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "DenyInternetInBound"
    description                = "Deny direct access from the Internet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "VirtualNetwork"
  }

}

# Create a Network Interface.

resource "azurerm_network_interface" "main" {
  count = var.vm_count

  name                = "${var.prefix}-nic-${var.vm_names[count.index]}"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a Public IP.
resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-publicIp"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  allocation_method   = "Static"

}
# Create a Load Balancer. 

resource "azurerm_lb" "main" {
  name                = "${var.prefix}-lb"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.main.id
  }

}

# Your load balancer will need a backend address pool 
# and address pool association for the network interface and the load balancer.

resource "azurerm_lb_backend_address_pool" "main" {
  loadbalancer_id     = azurerm_lb.main.id
  name                = "BackEndAddressPool"
}

# Create a virtual machine availability set.

resource "azurerm_availability_set" "main" {
  name                        = "${var.prefix}-aset"
  location                    = data.azurerm_resource_group.main.location
  resource_group_name         = data.azurerm_resource_group.main.name
  platform_fault_domain_count = 2
}

# Create virtual machines. Make sure you use the image you deployed using Packer!
# Create managed disks for your virtual machines.
# Ensure a variables file allows for customers to configure the number of virtual machines 
# and the deployment at a minimum.

resource "azurerm_linux_virtual_machine" "main" {
  count = var.vm_count

  name                            = "${var.prefix}-vm-${var.vm_names[count.index]}"
  resource_group_name             = data.azurerm_resource_group.main.name
  location                        = data.azurerm_resource_group.main.location
  size                            = "Standard_B1s"
  admin_username                  = "${var.username}"
  admin_password                  = "${var.password}"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.main[count.index].id,
  ]

  availability_set_id = azurerm_availability_set.main.id
  source_image_id     = var.packerImageId

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

resource "azurerm_managed_disk" "main" {
  name                 = "${var.prefix}-md"
  location             = data.azurerm_resource_group.main.location
  resource_group_name  = data.azurerm_resource_group.main.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"

}
