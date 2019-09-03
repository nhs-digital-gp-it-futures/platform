resource "azurerm_network_interface" "vm" {
  name                = "${var.project}-nic-${var.environment}"
  location            = "${var.region}"
  resource_group_name = "${azurerm_virtual_network.vnet.name}"

  ip_configuration {
    name                          = "${var.project}-staticip-${var.environment}"
    subnet_id                     = "${azurerm_subnet.bastion.id}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.project}-bastion-${var.environment}"
  location              = "${var.region}"
  resource_group_name   = "${azurerm_resource_group.virtual_machine.name}"
  network_interface_ids = ["${azurerm_network_interface.vm.id}"]
  vm_size               = "Standard_D2_v3"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "gpitfuturebastion"
    admin_username = "gpitadmin"
    admin_password = "9U5Fdq4KGKYkn&WnpFGRU@&m"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "${var.environment}"
  }
}