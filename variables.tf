##########################################
# Terraform Variables
# Ekip Rolleri & İzinler yapılandırması
##########################################

variable "github_organization" {
  description = "GitHub organization name"
  type        = string
}

variable "github_token" {
  description = "GitHub personal access token with organization-level permissions"
  type        = string
  sensitive   = true
}

# =============================
# PROJE YAPILARI VE HİYERARŞİ
# =============================
variable "projects" {
  description = <<EOT
Proje yapılandırma haritası:
{
  "project_name" = {
    lead            = "username"
    team_permission = "push|pull|triage|maintain"
    repositories = [
      {
        name        = "repo-name"
        description = "Açıklama"
        visibility  = "public|private"
      }
    ]
    members = [
      {
        username = "user-name"
        role     = "maintainer|member"
      }
    ]
  }
}
EOT

  type = map(object({
    lead            = string
    team_permission = string
    repositories = list(object({
      name        = string
      description = string
      visibility  = string
    }))
    members = list(object({
      username = string
      role     = string
    }))
  }))

  # =============================
  # Girdi doğrulamaları
  # =============================

  validation {
    condition = alltrue([
      for _, project in var.projects :
      contains(["pull", "triage", "push", "maintain"], project.team_permission)
    ])
    error_message = "Team permission must be one of: pull, triage, push, maintain."
  }

  validation {
    condition = alltrue([
      for _, project in var.projects :
      alltrue([
        for repo in project.repositories :
        contains(["public", "private"], repo.visibility)
      ])
    ])
    error_message = "Repository visibility must be either 'public' or 'private'."
  }

  validation {
    condition = alltrue([
      for _, project in var.projects :
      alltrue([
        for member in project.members :
        contains(["member", "maintainer"], member.role)
      ])
    ])
    error_message = "Team member role must be either 'member' or 'maintainer'."
  }
}
