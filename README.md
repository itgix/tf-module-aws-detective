The Terraform module is used by the ITGix AWS Landing Zone - https://itgix.com/itgix-landing-zone/

# AWS Detective Terraform Module

This module enables Amazon Detective across an AWS Organization. It creates the Detective behavior graph from the organization security (delegated administrator) account, configures auto-enrollment of new accounts, and enrolls existing member accounts as graph members.

Part of the [ITGix AWS Landing Zone](https://itgix.com/itgix-landing-zone/).

## Resources Created

- Amazon Detective behavior graph
- Detective organization configuration (auto-enable for new accounts)
- Member account associations for existing organization accounts

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `detective_organization_security_account` | Set to true when running from the organization security account to configure Amazon Detective | `bool` | `false` | no |
| `detective_auto_enable_new_accounts` | Whether Amazon Detective should automatically enable new AWS Organization member accounts | `bool` | `true` | no |
| `organization_member_accounts` | List of existing AWS Organization member accounts to enroll. Each object must include `account_id` and `email_address` | `list(object({account_id, email_address}))` | `[]` | no |
| `detective_invitation_message` | Invitation message sent when enrolling existing member accounts | `string` | `"Amazon Detective invitation from ITGix Landing Zone admin"` | no |
| `disable_email_notification` | Whether email notifications are disabled when enrolling existing member accounts | `bool` | `true` | no |
| `detective_tags` | Tags to apply to the Amazon Detective behavior graph | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `detective_graph_arn` | ARN of the Amazon Detective behavior graph |
| `detective_graph_id` | ID of the Amazon Detective behavior graph |

## Usage Example

```hcl
module "detective" {
  source = "path/to/tf-module-aws-detective"

  detective_organization_security_account = true
  detective_auto_enable_new_accounts      = true

  organization_member_accounts = [
    {
      account_id    = "333333333333"
      email_address = "account-a@example.com"
    },
    {
      account_id    = "444444444444"
      email_address = "account-b@example.com"
    }
  ]

  detective_tags = {
    Environment = "security"
    ManagedBy   = "terraform"
  }
}
```
