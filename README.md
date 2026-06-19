The Terraform module is used by the ITGix AWS Landing Zone - https://itgix.com/itgix-landing-zone/

# AWS Detective Terraform Module

This module deploys Amazon Detective behavior graph resources for AWS Organizations, including organization auto-enable settings and optional enrollment of existing member accounts.

Part of the [ITGix AWS Landing Zone](https://itgix.com/itgix-landing-zone/).

## Resources Created

- Amazon Detective behavior graph
- Detective organization configuration (auto-enable for new accounts)
- Detective member enrollments for existing organization accounts

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `detective_organization_security_account` | Set to true when running from the organization security account to configure Amazon Detective | `bool` | `false` | no |
| `detective_auto_enable_new_accounts` | Whether Amazon Detective automatically enables new AWS Organization member accounts | `bool` | `true` | no |
| `organization_member_accounts` | Existing AWS Organization member accounts to enroll, each with `account_id` and `email_address` | `list(object({ account_id = string, email_address = string }))` | `[]` | no |
| `detective_invitation_message` | Invitation message for enrolling existing member accounts | `string` | `"Amazon Detective invitation from ITGix Landing Zone admin"` | no |
| `disable_email_notification` | Whether email notifications are disabled when inviting existing member accounts | `bool` | `true` | no |
| `detective_tags` | Tags to apply to the Detective behavior graph | `map(string)` | `{}` | no |

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
			account_id    = "111111111111"
			email_address = "security-account@example.com"
		},
		{
			account_id    = "222222222222"
			email_address = "shared-services@example.com"
		}
	]

	disable_email_notification = true

	detective_tags = {
		Environment = "security"
		ManagedBy   = "terraform"
	}
}
```
