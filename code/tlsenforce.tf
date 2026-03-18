resource "azurerm_storage_account" "secure_storage" {
  name                     = "stsovereignprod001"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  # Preventing the "Wallpaper over Insulation" problem
  min_tls_version          = "TLS1_2"
  public_network_access_enabled = false

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }

  tags = {
    environment = "production"
    sovereignty  = "compliant"
  }
}
