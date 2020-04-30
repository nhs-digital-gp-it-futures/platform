# bastion terraform. 1x Windows box + bastion host in terraform, connected in Uk South to 

# Resource group for the bastion & bastion pc
resource "azurerm_resource_group" "bastion" {
  name                            = "${var.project}-${var.environment}-rg-bastion"
  location                        = var.region
  tags = {
    environment                   = var.environment
  }
}

# Public IP for the bastion
resource "azurerm_public_ip" "bastion" {
  name                = "${var.project}-${var.environment}-bastion-pip"
  location            = var.region
  resource_group_name = azurerm_resource_group.bastion.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#Subnet for bastion jump box
resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.sub_bastion
}


# Bastion service itself
resource "azurerm_bastion_host" "bastion" {
  name                = "${var.project}-${var.environment}-bastion"
  resource_group_name = azurerm_resource_group.bastion.name
  
  location                        = var.region
  tags = {
    environment                   = var.environment
  }

  ip_configuration {
    name                 = "${var.project}-bastionip"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}


#Subnet for bastion jump box
resource "azurerm_subnet" "bastion_jump" {
  name                 = "${var.project}-${var.environment}-${var.sub}-bst-jmp"
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.sub_bastion_jump

}

# Network Security Group for jump box
resource "azurerm_network_security_group" "bastion_jump" {
  name                = "${var.project}-${var.environment}-${var.nsg}-bst-jmp"
  location            = var.region
  resource_group_name = azurerm_resource_group.vnet.name
  tags = {
    environment = var.environment
  }
}

# Associate network security group with subnet.
resource "azurerm_subnet_network_security_group_association" "bastion_jump_subnet_assoc" {
  subnet_id                 = azurerm_subnet.bastion_jump.id
  network_security_group_id = azurerm_network_security_group.bastion_jump.id
}

# Network Interface for jump box
resource "azurerm_network_interface" "bastion_jump_nic" {
  name                      = "${var.project}-${var.environment}-bstn-nic"
  location                  = var.region
  resource_group_name       = azurerm_resource_group.bastion.name  

ip_configuration {
    name                          = "${var.project}-${var.environment}-bstn-nic-ip"
    subnet_id                     = azurerm_subnet.bastion_jump.id
    private_ip_address_allocation = "dynamic"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_virtual_machine" "jump" {
    name                           = "${var.project}-${var.environment}-jump"
    location                       = var.region
    resource_group_name            = azurerm_resource_group.bastion.name
    network_interface_ids          = [azurerm_network_interface.bastion_jump_nic.id]
    vm_size                        = "Standard_B1ms"
    delete_os_disk_on_termination  = true
 
 
#--- Base OS Image ---
   storage_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "rs5-pro"
    version   = "latest"
  }
 
 
#--- Disk Storage Type
 
  storage_os_disk {
    name              = "disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    os_type           = "Windows"
  }
 
 
 
#--- Define password + hostname ---
  os_profile {
    computer_name  = "Jump"
    admin_username = data.azurerm_key_vault_secret.kv-buser.value
    admin_password = data.azurerm_key_vault_secret.kv-bpass.value
  }
 
#---
 
  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent = true
  }
 
#-- Windows VM Diagnostics 
 
  boot_diagnostics {
    enabled     = false
    storage_uri = ""
 }
 
 
#--- VM Tags
  tags = {
    environment = var.environment
  }
#--- Post Install Provisioning ---
}

