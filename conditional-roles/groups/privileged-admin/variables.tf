variable "project_id" {
    type = string
}
variable "members" { 
    type = list(string)
    validation {
      condition = (alltrue ([
        for member in var.members:
          !can(regex("^group:.*_priv_read@hca\\.corpad\\.net$", member))
        ]))
      error_message = "Only service accounts are allowed to be passed as members with the format serviceAccount:<PRINCIPAL>."
    }

    validation {
      condition = (alltrue ([
        for member in var.members:
          !can(regex("^group:.*_priv_write@hca\\.corpad\\.net$", member))
        ]))
      error_message = "Only service accounts are allowed to be passed as members with the format serviceAccount:<PRINCIPAL>."
    }
}