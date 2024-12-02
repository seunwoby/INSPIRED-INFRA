
resource "azuread_application_pre_authorized" "preauth" {
  count = length(var.known_apps)

  application_id       = azuread_application.app.id
  authorized_client_id = var.known_apps[count.index].client_id

  permission_ids = [ for p in var.known_apps[count.index].scopes : azuread_application.app.oauth2_permission_scope_ids[p] ]
}
