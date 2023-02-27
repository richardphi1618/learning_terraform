###
# Networking
###

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet01" {
  name                = "${var.loc_short}-${var.app_name}-vnet01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
  tags                = azurerm_resource_group.rg.tags
}

# Create a subnet within the resource group
resource "azurerm_subnet" "subnet01" {
  name                 = "${var.loc_short}-${var.app_name}-vnet01-web"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.0.1.0/24"]
}

variable "whitelist_ip" {
  type = string
}

resource "azurerm_network_security_group" "subnet01_nsg" {
  name                = "${var.loc_short}-${var.app_name}-vnet01-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags

  security_rule {
    name                       = "SSH"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.whitelist_ip
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet01.id
  network_security_group_id = azurerm_network_security_group.subnet01_nsg.id
}
