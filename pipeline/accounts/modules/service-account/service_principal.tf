
resource "azuread_service_principal" "service_principal" {
  client_id                    = azuread_application.app.client_id
  app_role_assignment_required = false
  owners       = [for u in data.azuread_user.owners : u.id]
  use_existing = true
}
