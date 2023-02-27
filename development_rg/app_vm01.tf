#####
# VM
#####

resource "azurerm_linux_virtual_machine" "vm01" {
  name                = "${var.app_name}-machine"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic01.id,
  ]

  custom_data = filebase64("../templates/install_docker.sh")

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  # provisioner "local-exec"{
  #   command = templatefile("../templates/linux-ssh-script.tpl", {
  #     hostname = self.public_ip_address,
  #     user = self.admin_username,
  #     Identityfile = "~/.ssh/wsl_id_rsa"
  #   })
  #   # interpreter = ["Powershell","-Command"]
  #   interpreter = ["bash", "-c"]
  # }

  tags = azurerm_resource_group.rg.tags

}

resource "azurerm_public_ip" "pip01" {
  name                = "${var.app_name}-PublicIp1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"

  tags = azurerm_resource_group.rg.tags
}

resource "azurerm_network_interface" "nic01" {
  name                = "${var.app_name}-nic01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip01.id
  }
}

data "azurerm_public_ip" "pip01-data" {
  name                = azurerm_public_ip.pip01.name
  resource_group_name = azurerm_resource_group.rg.name
}