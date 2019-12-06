resource "azurerm_resource_group" "virtual_machine" {
  name     = "${var.project}-${var.environment}-rg-vm"
  location = "${var.region}"
  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_network_interface" "vm" {
  name                = "${var.project}-${var.environment}-nic"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.virtual_machine.name}"

  ip_configuration {
    name                          = "${var.project}-${var.environment}-staticip"
    subnet_id                     = "${azurerm_subnet.bastion.id}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.project}-${var.environment}-bastion"
  location              = "${var.region}"
  resource_group_name   = "${azurerm_resource_group.virtual_machine.name}"
  network_interface_ids = ["${azurerm_network_interface.vm.id}"]
  vm_size               = "${var.vm_size}"

  storage_image_reference {
    publisher                       = "${var.vm_publisher}"
    offer                           = "${var.vm_offer}"
    sku                             = "${var.vm_sku}"
    version                         = "${var.vm_version}"
  }

  storage_os_disk {
    name                            = "gpitos${var.environment}disk1"
    caching                         = "ReadWrite"
    create_option                   = "FromImage"
    managed_disk_type               = "Standard_LRS"
    disk_size_gb                    = "30"
  }

  os_profile {
    computer_name                   = "${var.project}bastion"
    admin_username                  = "${data.azurerm_key_vault_secret.kv-buser.value}"
    admin_password                  = "${data.azurerm_key_vault_secret.kv-bpass.value}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags                              = {
    environment                     = "${var.environment}"
  }
}