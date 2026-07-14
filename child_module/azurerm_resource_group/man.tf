resource "azurerm_resource_group" "rgm" {
  for_each = var.rgs

  name = each.value.name
  location = each.value.location
}
