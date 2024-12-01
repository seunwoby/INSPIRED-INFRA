module "global-study_canvas" {
  source           = "../modules/service-account"
  app_name         = "canvas"
  namespace_name   = "global-study"
  environment_name = var.environment
  spa_redirect_uris = [
    "https://admin-test.inspirededucationschools.com/signin-oidc",
    "http://localhost:5240/signin-oidc"  
  ]
  spa_uses_access_tokens = true
  spa_uses_id_tokens     = true
  roles = [
    {
      "role"        = "CanvasManager.Admin"
      "description" = "Manage any school in the canvas maanger"
    }
  ]
}

