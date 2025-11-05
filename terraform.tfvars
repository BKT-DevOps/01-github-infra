# =============================
# GITHUB CONFIGURATION
# =============================
github_organization = "BKT-DevOps"

# GitHub Personal Access Token
# ⚠️ Güvenlik Notu:
# Bu değer .env dosyasında ya da Terraform Cloud ortam değişkeninde saklanmalıdır.
# Aşağıdaki satır sadece development/test ortamında örnek içindir.
github_token = "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# =============================
# PROJECTS CONFIGURATION
# =============================
projects = {
  "project-alpha" = {
    lead            = "flovearth"
    team_permission = "push"

    repositories = [
      {
        name            = "to-do-api"
        description     = "API service for Project To-Do"
        visibility      = "public"
        project_name    = "project-alpha"
        team_permission = "push"
        lead            = "flovearth"
      },
      {
        name            = "to-do-web"
        description     = "Web interface for Project To-Do"
        visibility      = "public"
        project_name    = "project-alpha"
        team_permission = "push"
        lead            = "flovearth"
      }
    ]

    members = [
      { username = "ismailaricioglu", role = "maintainer" },
      { username = "hulyaoner", role = "member" },
      { username = "lerkush", role = "member" },
      { username = "flovearth", role = "member" }
    ]
  }

  "project-beta" = {
    lead            = "ismailaricioglu"
    team_permission = "push"

    repositories = [
      {
        name            = "communication-service"
        description     = "Core service for Project Communication"
        visibility      = "public"
        project_name    = "project-beta"
        team_permission = "push"
        lead            = "ismailaricioglu"
      }
    ]

    members = [
      { username = "lerkush", role = "maintainer" },
      { username = "ismailaricioglu", role = "member" },
      { username = "hulyaoner", role = "member" },
      { username = "egeren", role = "member" }
    ]
  }

  "project-gamma" = {
    lead            = "egeren"
    team_permission = "triage"

    repositories = [
      {
        name            = "general-docs"
        description     = "Documentation for Project General Docs"
        visibility      = "public"
        project_name    = "project-gamma"
        team_permission = "triage"
        lead            = "egeren"
      }
    ]

    members = [
      { username = "egeren", role = "maintainer" },
      { username = "UsainSasal", role = "member" },
      { username = "onurceylan", role = "member" }
    ]
  }

  "Documentation" = {
    lead            = "flovearth"
    team_permission = "push"

    repositories = [
      {
        name            = "01-Documentation"
        description     = "Topluluk için genel dokümantasyon"
        visibility      = "public"
        project_name    = "Documentation"
        team_permission = "push"
        lead            = "flovearth"
      }
    ]

    members = [
      { username = "flovearth", role = "maintainer" },
      { username = "ismailaricioglu", role = "maintainer" },
      { username = "onurceylan", role = "member" },
      { username = "UsainSasal", role = "member" },
      { username = "egeren", role = "member" },
      { username = "hulyaoner", role = "member" },
      { username = "lerkush", role = "member" }
    ]
  }
}
