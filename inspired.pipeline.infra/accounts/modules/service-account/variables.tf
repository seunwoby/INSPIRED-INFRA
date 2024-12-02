variable "app_name" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "namespace_name" {
  type = string
}

variable "keyvault_id" {
    type = string
    default = ""
}

variable "spa_redirect_uris" {
    type = list(string)
    default = []
}

variable "spa_uses_access_tokens" {
    type = bool
    default = false
}

variable "spa_uses_id_tokens" {
    type = bool
    default = false
}

variable "roles" {
    type = list(any)
    default = []
    # example value:
    # roles = [
    # {
    #   "role"        = "FeatureFlags.Read"
    #   "description" = "Read feature flags"
    # },
    # {
    #   "role"        = "FeatureFlags.Write"
    #   "description" = "Write feature flags"
    # }
}

variable "known_apps" {
    type = list(any)
    default = []
    # example value:
    # [
    #     {
    #         client_id = "00000000-0000-0000-0000-000000000000"
    #         scopes = [
    #             "default"
    #         ]
}

variable "accessable_apps" {
    type = list(any)
    default= []
    # example value:
    # [
    #     {
    #         application_id = "00000000-0000-0000-0000-000000000000"
    #         roles = [
    #             "FeatureFlags.Write"
    #         ]
    #         scopes = [
    #             "user.read"
    #         ]
    #     }
    # ]
}

variable "owners" {
    type = list(string)
    default = [
        "Simon.Dainty@inspirededu.com", 
        "Andrew.Skirrow@inspirededu.com", 
        "Steve.Esson@inspirededu.co.uk",
        "seun.okuwobi@inspirededu.com",
        "_admin.Seun.Okuwobi@inspirededu.com"
        ]
}


