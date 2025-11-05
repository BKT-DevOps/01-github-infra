variable "github_organization" {
  description = "GitHub organization name"
  type        = string
}

variable "github_token" {
  description = "GitHub personal access token with appropriate permissions"
  type        = string
  sensitive   = true
}

variable "projects" {
  description = "Map of projects with their configuration"
  type = map(object({
    lead            = string
    team_permission = string
    repositories = list(object({
      name        = string
      description = string
      visibility  = string
      license     = optional(string)
    }))
    members = list(object({
      username = string
      role     = string
    }))
  }))

  validation {
    condition = alltrue([
      for project_name, project in var.projects :
      contains(["pull", "triage", "push", "maintain"], project.team_permission)
    ])
    error_message = "Team permission must be one of: pull, triage, push, maintain"
  }

  validation {
    condition = alltrue([
      for project_name, project in var.projects :
      alltrue([
        for repo in project.repositories :
        contains(["public", "private"], repo.visibility)
      ])
    ])
    error_message = "Repository visibility must be either 'public' or 'private'"
  }

  validation {
    condition = alltrue([
      for project_name, project in var.projects :
      alltrue([
        for member in project.members :
        contains(["member", "maintainer"], member.role)
      ])
    ])
    error_message = "Team member role must be either 'member' or 'maintainer'"
  }
}