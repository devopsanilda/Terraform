resource "azurerm_virtual_machine" "vm" {
 count                 = "${var.adet}"
 name                  = "acctvm${count.index}"
 location              = "${var.location}"
 resource_group_name   = "${azurerm_resource_group.testClient-rg.name}"
 network_interface_ids = ["${element(azurerm_network_interface.nic.*.id, count.index)}"]
 vm_size               = "Standard_A2"
 delete_os_disk_on_termination = true

  storage_image_reference {
   publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "datadisk_new_${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "acctvm${count.index}"
    admin_username = "${var.username}"
    admin_password = "${var.password}"
  }

  os_profile_windows_config {
    enable_automatic_upgrades = false
    provision_vm_agent        = true

  }
}
