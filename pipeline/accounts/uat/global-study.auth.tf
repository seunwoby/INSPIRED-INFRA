module "global-study_auth" {
  source           = "../modules/service-account"
  app_name         = "auth"
  namespace_name   = "global-study"
  environment_name = var.environment
  roles = [
    {
      "role"        = "Masquerade.AnyUser"
      "description" = "Masquerade as any user"
    }
  ]
}

