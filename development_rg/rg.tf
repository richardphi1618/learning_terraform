# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.loc_short}-${var.app_name}-Dev"
  location = var.location
  tags     = var.tags
}