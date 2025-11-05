######################################
#   LOCALS CONFIGURATION
#   Author: kardeşim
#   Description: Centralized reusable constants
#   Updated: 2025-11-04
######################################

# ──────────────────────────────────────────────
# Global constants and reusable naming schema
# ──────────────────────────────────────────────

locals {
  # Organization-wide standard prefix
  org_prefix = "BKT"

  # Default repository visibility for quick reference
  default_visibility = "private"

  # Default team permission level
  default_permission = "push"

  # Centralized tag metadata for consistency
  default_tags = {
    managed_by = "Terraform"
    org        = local.org_prefix
    environment = "dev"
  }

  # Naming convention helpers
  # All repositories and teams will follow this format automatically
  naming_rules = {
    team_format = lower(replace("${local.org_prefix}-${each.key}", " ", "-"))
    repo_format = lower(replace("${local.org_prefix}-${each.value.repositories[*].name}", " ", "-"))
  }

  # Derived summary data for informational outputs
  summary = {
    total_projects     = length(var.projects)
    total_repositories = sum([for project in values(var.projects) : length(project.repositories)])
    total_members      = length(distinct(flatten([for project in values(var.projects) : [for m in project.members : m.username]])))
  }

  # Lead mapping for quick reference (helps automation and reporting)
  leads = { for project_name, project in var.projects : project_name => project.lead }

  # Default GitHub organization
  organization = var.github_organization

  # Secure token reference
  github_token = var.github_token
}

######################################
# OUTPUT PREVIEW (optional)
######################################
# You can test locals with:
# terraform console
# > local.summary
# > local.naming_rules
######################################
