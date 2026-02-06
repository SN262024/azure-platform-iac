resource "azurerm_linux_virtual_machine_scale_set" "this" {
  for_each = var.vmss

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku
  instances           = each.value.instances
  admin_username      = each.value.admin_user
  computer_name_prefix = "vmss${replace(each.key, "_", "")}"

  disable_password_authentication = true

  admin_ssh_key {
    username   = each.value.admin_user
    public_key = each.value.ssh_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "vmss-nic"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                               = true
      subnet_id                             = each.value.subnet_id
      load_balancer_backend_address_pool_ids = [ each.value.backend_pool_id]
    }
  }
}
