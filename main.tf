resource "azurerm_virtual_network" "vnet" {
  name                = "testClientrgvnet"
  address_space       = ["*.*.*.0/24"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.testClient-rg.name}"
  dns_servers         = ["* * * *", "* * * *"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "testClientrgsubnet"
  resource_group_name  = "${azurerm_resource_group.testClient-rg.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "****/24"
}

resource "azurerm_network_interface" "nic" {
 count               = "${var.adet}"
 name                = "acctni${count.index}"
 location            = "${var.location}"
 resource_group_name = "${azurerm_resource_group.testClient-rg.name}"

 ip_configuration {
   name                          = "testClientrgNicconfiguration"
   subnet_id                     = "${azurerm_subnet.subnet.id}"
   private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "testClientrgnsg"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.testClient-rg.name}"

  security_rule {
    name                       = "RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_storage_account" "storageacc" {
  name                     = "testlientrgstoacc"
  resource_group_name      = "${azurerm_resource_group.testClient-rg.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
