
module "core_general" {
  source           = "../modules/service-account"
  app_name         = "general"
  namespace_name   = "core"
  environment_name = var.environment

  known_apps = [
    {
        client_id = module.global-study_platform.client_id
        scopes = [
            "default"
        ]
    }
  ]

  roles = [
    {
      "role"        = "FeatureFlags.Read"
      "description" = "Read feature flags"
    },
    {
      "role"        = "FeatureFlags.Write"
      "description" = "Write feature flags"
    }
  ]
}


