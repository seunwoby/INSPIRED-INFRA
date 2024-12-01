

locals {
  env_codes_map = {
      "test" = "t"
      "uat" = "u"
      "production" = "p"
      "prod" = "p"
  }
  pod_resource_group = format("ieg-%s-pods-data", var.environment_name)
  env_short_code = lookup(local.env_codes_map, var.environment_name, "t")
  keyvault_name = substr(format("ieg%s-%s-%s", local.env_short_code, var.namespace_name, var.app_name), 0, 24)
}

data "azurerm_key_vault" "keyvault" {
  name = local.keyvault_name
  resource_group_name = local.pod_resource_group
}

resource "azuread_application_password" "sec" {
  application_id = azuread_application.app.id
  end_date = "2999-01-01T00:00:00Z"
}

resource "azurerm_key_vault_secret" "client_id" {
    name = "InspiredAppClientId"
    value = azuread_application.app.client_id
    key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "client_password" {
    name = "InspiredAppClientSecret"
    value = azuread_application_password.sec.value
    key_vault_id = data.azurerm_key_vault.keyvault.id
}



