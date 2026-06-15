variable "detective_organization_security_account" {
  type        = bool
  default     = false
  description = "Set to true when running from the organization security account to configure Amazon Detective."
}

variable "detective_auto_enable_new_accounts" {
  type        = bool
  default     = true
  description = "Whether Amazon Detective should automatically enable new AWS Organization member accounts."
}

variable "organization_member_accounts" {
  description = "List of existing AWS Organization member accounts to enroll in Amazon Detective. Each object must include the member account ID and email address."
  type = list(object({
    account_id    = string
    email_address = string
  }))
  default = []
}

variable "detective_invitation_message" {
  type        = string
  default     = "Amazon Detective invitation from ITGix Landing Zone admin"
  description = "Invitation message sent when enrolling existing member accounts into Amazon Detective."
}

variable "disable_email_notification" {
  type        = bool
  default     = true
  description = "Whether email notifications are disabled when enrolling existing Amazon Detective member accounts."
}

variable "detective_tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the Amazon Detective behavior graph."
}
