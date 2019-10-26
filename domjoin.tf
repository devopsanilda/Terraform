resource "azurerm_virtual_machine_extension" "adjoin" {
  count                = "${var.adet}"
  name                 = "acctvm${count.index}"
  location             = "Westeurope"
  resource_group_name  = "${azurerm_resource_group.testClient-rg.name}"
  virtual_machine_name = "acctvm${count.index}"
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"

  settings = <<SETTINGS
    {
        "Name": "*.*.com",
        "OUPath": "OU=Azure,OU=Apps Servers,OU=Production Servers,OU=AppServers,DC=****,DC=***,DC=com",
        "User": "DOMAIN\\SERVICE ACCOUNT",
        "Restart": "true",
        "Options": "3"
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
        "Password": "*******"
    }
PROTECTED_SETTINGS

depends_on = ["azurerm_virtual_machine.vm"]
}
