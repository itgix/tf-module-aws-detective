resource "aws_detective_graph" "itgix_primary" {
  count = var.detective_organization_security_account ? 1 : 0

  tags = var.detective_tags
}

resource "aws_detective_organization_configuration" "itgix_primary" {
  count = var.detective_organization_security_account ? 1 : 0

  graph_arn   = aws_detective_graph.itgix_primary[0].graph_arn
  auto_enable = var.detective_auto_enable_new_accounts
}

resource "aws_detective_member" "itgix_primary" {
  for_each = var.detective_organization_security_account ? {
    for member in var.organization_member_accounts : member.account_id => member
  } : {}

  graph_arn                  = aws_detective_graph.itgix_primary[0].graph_arn
  account_id                 = each.value.account_id
  email_address              = each.value.email_address
  message                    = var.detective_invitation_message
  disable_email_notification = var.disable_email_notification
}
