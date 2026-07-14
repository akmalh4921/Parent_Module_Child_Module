output "pip_ids" {
  value = {
    for key, pip in azurerm_public_ip.pip : key => pip.id
  }
}