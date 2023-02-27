output "public_ip_address_01" {
  value = "${azurerm_linux_virtual_machine.vm01.name}: ${data.azurerm_public_ip.pip01-data.ip_address}"
}

output "rg_tags" {
  value = "${azurerm_resource_group.rg.tags}"
}