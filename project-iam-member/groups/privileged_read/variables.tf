variable "roles" {
    type = list(string)
}

variable "member" {
  type = string
  validation {
    condition = (alltrue([
      !can(regex("group:.*._priv_read@andrewchasin\\.joonix\\.net$", var.member)), can(regex("^group:.*", var.member))
    ]))
    error_message = "Only service accounts are allowed to be passed as members with the format serviceAccount:<PRINCIPAL>."
  }
}