#---------------------------------------------------------------------------------------------
# Base GCP Variables
#---------------------------------------------------------------------------------------------

variable "project_id" {
  type        = string
  description = "The ID of the project in which the resource belongs."
  default     = "sandbox-350815" //TODO: change to no default
}

# variable "labels" {
#   type        = map(string)
#   description = "A set of key/value label pairs to assign to the resource."
# }


variable "additive_conditional_bindings" {
  type = list(object({
    members           = list(string)
    conditional_roles = list(string)
  }))
  default = [{
    "members"           = [""]
    "conditional_roles" = [""]
  }]

}

variable "additive_default_bindings" {
  type = list(object({
    members = list(string)
    role    = list(string)
    # conditional_roles = string
  }))
  default = [{
    "members" = ["serviceAccount:delegated-role-test@sandbox-350815.iam.gserviceaccount.com"]
    "role"    = [""]
    # "conditional_roles" = ""
  }]
}

variable "additive_member_bindings" {
  type = list(object({
    members           = list(string)
    role              = list(string)
    conditional_roles = string
  }))
  default = [{
    "members"           = ["serviceAccount:delegated-role-test@sandbox-350815.iam.gserviceaccount.com"]
    "role"              = [""]
    "conditional_roles" = ""
  }]
}


# variable "enable_apis" { #not sure if this is needed considering the counts are not used and the dependencies use the output from project_services
#   type        = boolean
#   description = "Whether to  enable the APIs. See https://github.com/terraform-google-modules/terraform-google-project-factory/tree/master/modules/project_services"
#   default     = true
# }
