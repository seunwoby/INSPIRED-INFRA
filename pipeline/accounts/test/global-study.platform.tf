module "global-study_platform" {
  source           = "../modules/service-account"
  app_name         = "platform"
  namespace_name   = "global-study"
  environment_name = var.environment
  spa_redirect_uris = [
    "https://admin-test.inspirededucationschools.com/",
    "https://localhost.inspirededucationschools.com:3000/"  
  ]
  spa_uses_access_tokens = true
  spa_uses_id_tokens     = true
  accessable_apps = [
    {
      client_id = module.core_general.client_id
      roles = [
        "FeatureFlags.Read",
        "FeatureFlags.Write",
      ]
      scopes = [
        "default"
      ]
    }
  ]
  roles = [
    {
      "role"        = "Masquerade.AnyUser"
      "description" = "Masquerade as any user"
    }
  ]
}

