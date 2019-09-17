resource "azurerm_resource_group" "virtual_machine" {
  name                                = "${var.project}-vm-${var.environment}"
  location                            = "${var.region}"

  tags = {
    environment                       = "${var.environment}"
  }
}

resource "azurerm_network_interface" "vm" {
  name                                = "${var.project}-nic-${var.environment}"
  location                            = "${var.region}"
  resource_group_name                 = "${azurerm_virtual_network.vnet.name}"

  ip_configuration {
    name                              = "${var.project}-staticip-${var.environment}"
    subnet_id                         = "${azurerm_subnet.bastion.id}"
    private_ip_address_allocation     = "dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                                = "${var.project}-bastion-${var.environment}"
  location                            = "${var.region}"
  resource_group_name                 = "${azurerm_resource_group.virtual_machine.name}"
  network_interface_ids               = ["${azurerm_network_interface.vm.id}"]
  vm_size                             = "Standard_D2_v3"

  storage_image_reference {
    publisher                         = "Canonical"
    offer                             = "UbuntuServer"
    sku                               = "18.04-LTS"
    version                           = "latest"
  }
  storage_os_disk {
    name                              = "myosdisk1"
    caching                           = "ReadWrite"
    create_option                     = "FromImage"
    managed_disk_type                 = "Standard_LRS"
  }
  os_profile {
    computer_name                     = "gpitfuturebastion"
    admin_username                    = "${data.azurerm_key_vault_secret.kv-buser.value}"
    admin_password                    = "${data.azurerm_key_vault_secret.kv-bpass.value}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment                       = "${var.environment}"
  }
}