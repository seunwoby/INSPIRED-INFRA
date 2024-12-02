locals {
  appname_uuid_ns = "7cd58c86-0362-4cb8-bd03-77a9eb1f2995"
  roleid_uuid_ns = "c96d3368-66dc-43cf-b62d-68c583eda519"
  application_name      = "${var.environment_name}-${var.namespace_name}-${var.app_name}"
  application_name_uuid = uuidv5(local.appname_uuid_ns, local.application_name)
  idenfifier_uri = "urn:inspired-api:${local.application_name}"
}

data "azuread_client_config" "current" {}

data "azuread_group" "softwaread" {
  display_name     = "Software Development AD"
  include_transitive_members = true
  security_enabled = true
}

data "azuread_user" "owners" {
  count = length(var.owners)
  user_principal_name = var.owners[count.index]
}

resource "azuread_application" "app" {
  display_name = local.application_name
  owners       = [for u in data.azuread_user.owners : u.id]
  identifier_uris = [local.idenfifier_uri]

  lifecycle {
    ignore_changes = [required_resource_access, app_role]
  }

  api {
    oauth2_permission_scope {
      admin_consent_description  = "allow the application to access ${local.application_name}"
      admin_consent_display_name = "access ${local.application_name}"
      id                         = local.application_name_uuid
      type                       = "User"
      value                      = "default"
    }
  }

  single_page_application {
      redirect_uris = var.spa_redirect_uris 
  }
}

resource "azuread_application_app_role" "app_roles" {
  count = length(var.roles)

  application_id = azuread_application.app.id
  role_id =             uuidv5(local.roleid_uuid_ns, var.roles[count.index].role) 
  allowed_member_types  = ["User", "Application"]
  description           = var.roles[count.index].description
  display_name          = var.roles[count.index].role
  value                 = var.roles[count.index].role
}

resource "azuread_application_api_access" "permissions" {
  count = length(var.accessable_apps)
  application_id = azuread_application.app.id
  api_client_id = var.accessable_apps[count.index].client_id
  #role_ids = [for p in var.accessable_apps[count.index].roles : uuidv5(local.roleid_uuid_ns, p)]
  role_ids = [for p in var.accessable_apps[count.index].roles : data.azuread_application.accessable_apps[count.index].app_role_ids[p]]
  scope_ids = [for p in var.accessable_apps[count.index].scopes : data.azuread_application.accessable_apps[count.index].oauth2_permission_scope_ids[p]]
}

data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph" {
  client_id = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]
}

data "azuread_application" "accessable_apps" {
    count = length(var.accessable_apps)
    client_id = var.accessable_apps[count.index].client_id
}

resource "azuread_application_api_access" "userread" {
  application_id = azuread_application.app.id
  api_client_id  = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]

  scope_ids = [
    data.azuread_service_principal.msgraph.oauth2_permission_scope_ids["User.Read"],
  ]
}

