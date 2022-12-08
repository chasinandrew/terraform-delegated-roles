variable "project_id" {
    type = string
}
variable "members" { 
    type = list(string)
    validation {
      condition = (alltrue ([
        for member in var.members:
          can(regex("^serviceAccount:.*", member))
        ]))
      error_message = "Only service accounts are allowed to be passed as members with the format serviceAccount:<PRINCIPAL>."
    }
    #For privileged access groups, the privileged read must be able to grant ONLY non-admin roles. To do this, the validation block in here must have a regex to match privileged read groups. 
}
