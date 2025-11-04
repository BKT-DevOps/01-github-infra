provider "github" {
  owner = var.github_organization
  token = var.github_token
}

# Create teams for each project
resource "github_team" "project" {
  for_each    = var.projects
  name        = each.key
  description = "${each.key} projesi geliştirme ekibi"
  privacy     = "closed"
}

# Create repositories for each project
resource "github_repository" "repo" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  name        = each.key
  description = each.value.description
  visibility  = each.value.visibility

  has_issues   = true
  has_wiki     = true
  has_projects = true

  delete_branch_on_merge = true
  auto_init              = true

  # Enable branch protection
  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = false
  allow_auto_merge   = false

}

# Set up team access to repositories
resource "github_team_repository" "access" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  team_id    = github_team.project[each.value.project_name].id
  repository = github_repository.repo[each.key].name
  permission = each.value.team_permission
}

# Add team members
resource "github_team_membership" "members" {
  for_each = { for m in local.all_memberships : "${m.project}-${m.user}" => m }

  team_id  = github_team.project[each.value.project].id
  username = each.value.user
  role     = each.value.role
}

# Grant admin access to project leads
resource "github_repository_collaborator" "lead" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository = github_repository.repo[each.key].name
  username   = each.value.lead
  permission = "admin"
}

# Create additional branches for each repository
resource "github_branch" "develop" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository = github_repository.repo[each.key].name
  branch     = "develop"

  source_branch = try(github_repository.repo[each.key].default_branch, "main")

  depends_on = [github_repository.repo]
}

resource "github_branch" "release" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository = github_repository.repo[each.key].name
  branch     = "release"

  source_branch = try(github_repository.repo[each.key].default_branch, "main")

  depends_on = [github_repository.repo]
}

# Branch protection rules
resource "github_branch_protection" "main" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository_id = github_repository.repo[each.key].node_id
  pattern       = "main"

  required_status_checks {
    strict = true
  }

  required_pull_request_reviews {
    required_approving_review_count = 1
    dismiss_stale_reviews           = true
    restrict_dismissals             = false
    require_code_owner_reviews      = true
  }

  enforce_admins         = false
  allows_deletions       = false
  allows_force_pushes    = false
  require_signed_commits = true

  depends_on = [
    github_repository_file.docs_project,
    github_repository_file.readme,
    github_repository_file.codeowners,
    github_repository_file.docs_architecture,
    github_repository_file.docs_workflow
  ]
}

resource "github_repository_file" "codeowners" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository     = github_repository.repo[each.key].name
  branch         = "main"
  file           = ".github/CODEOWNERS"
  content        = "* @${each.value.lead}\n"
  commit_message = "Add CODEOWNERS file"

  overwrite_on_create = true

  depends_on = [
    github_repository.repo,
    github_team_repository.access,
    github_repository_collaborator.lead
  ]

  lifecycle {
    ignore_changes = [content]
  }
}

# Create labels for issues
resource "github_issue_label" "setup" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository  = github_repository.repo[each.key].name
  name        = "setup"
  color       = "1d76db"
  description = "Initial setup tasks"

  depends_on = [github_repository.repo]
}

resource "github_issue_label" "priority_high" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository  = github_repository.repo[each.key].name
  name        = "priority:high"
  color       = "d93f0b"
  description = "High priority tasks"

  depends_on = [github_repository.repo]
}

# Create initial setup issue for each project
resource "github_issue" "initial_setup" {
  for_each = { for project_name, project in var.projects : project_name => project }

  repository = github_repository.repo[local.project_main_repos[each.key]].name
  title      = "Initial Setup"
  body = replace(
    replace(
      file("${path.module}/sample_repo_docs/initial-setup-issue.md"),
      "{{PROJECT_NAME}}", each.key
    ),
    "{{PROJECT_LEAD}}", each.value.lead
  )

  assignees = [each.value.lead]
  labels    = ["setup", "priority:high"]

  depends_on = [
    github_repository.repo,
    github_issue_label.setup,
    github_issue_label.priority_high
  ]
}



# Create documentation pages in docs folder (can be used as wiki content)
# Note: Files are created after repository is fully initialized
resource "github_repository_file" "docs_project" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository = github_repository.repo[each.key].name
  file       = "docs/project_definition.md"
  content = replace(
    replace(
      file("${path.module}/sample_repo_docs/project_definition.md"),
      "{{PROJECT_NAME}}", each.value.project_name
    ),
    "{{PROJECT_LEAD}}", each.value.lead
  )
  commit_message = "Add project documentation"

  overwrite_on_create = true

  depends_on = [
    github_repository.repo,
    github_team_repository.access,
    github_repository_collaborator.lead
  ]

  lifecycle {
    ignore_changes = [content]
  }
}
# Architecture Overview dokümanı
resource "github_repository_file" "docs_architecture" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository     = github_repository.repo[each.key].name
  file           = "docs/Architecture-Overview.md"
  content        = file("${path.module}/sample_repo_docs/Architecture-Overview.md")
  commit_message = "Add Architecture Overview document"

  overwrite_on_create = true

  depends_on = [
    github_repository.repo,
    github_team_repository.access,
    github_repository_collaborator.lead
  ]
  lifecycle {
    ignore_changes = [content]
  }
}

# Development Workflow dokümanı
resource "github_repository_file" "docs_workflow" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository     = github_repository.repo[each.key].name
  file           = "docs/Development-Workflow.md"
  content        = file("${path.module}/sample_repo_docs/Development-Workflow.md")
  commit_message = "Add Development Workflow document"

  overwrite_on_create = true

  depends_on = [
    github_repository.repo,
    github_team_repository.access,
    github_repository_collaborator.lead
  ]
}

# Team sayfası için dinamik içerik
resource "github_repository_file" "team" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository = github_repository.repo[each.key].name
  file       = "docs/TEAM.md"

  content = replace(
    replace(
      replace(
        replace(
          replace(
            replace(
              file("${path.module}/sample_repo_docs/team.md"),
              "{{PROJECT_NAME}}", each.value.project_name
            ),
            "{{GITHUB_ORG}}", var.github_organization
          ),
          "{{PROJECT_LEAD}}", each.value.lead
        ),
        "{{MEMBER_COUNT}}", tostring(length(var.projects[each.value.project_name].members))
      ),
      "{{MAINTAINER_COUNT}}", tostring(length([
        for m in var.projects[each.value.project_name].members : m if m.role == "maintainer"
      ]))
    ),
    "{{REGULAR_MEMBER_COUNT}}", tostring(length([
      for m in var.projects[each.value.project_name].members : m if m.role == "member"
    ]))
  )

  commit_message      = "Add team documentation"
  overwrite_on_create = true

  depends_on = [
    github_repository.repo,
    github_team_repository.access,
    github_repository_collaborator.lead
  ]

  lifecycle {
    ignore_changes = [content]
  }
}

# Create comprehensive README for each repository
resource "github_repository_file" "readme" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository = github_repository.repo[each.key].name
  file       = "README.md"
  content = replace(
    replace(
      replace(
        replace(
          file("${path.module}/sample_repo_docs/readme.md"),
          "{{PROJECT_NAME}}", each.value.project_name
        ),
        "{{PROJECT_LEAD}}", each.value.lead
      ),
      "{{GITHUB_ORG}}", var.github_organization
    ),
    "{{REPO_NAME}}", each.key
  )
  commit_message = "Update README with project information"

  depends_on = [
    github_repository.repo,
    github_team_repository.access,
    github_repository_collaborator.lead
  ]

  overwrite_on_create = true # This will overwrite the auto-generated README

  lifecycle {
    ignore_changes = [content]
  }
}

# Opsiyonel: Wiki sayfaları
resource "github_repository_file" "wiki_home" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository = github_repository.repo[each.key].name
  file       = "docs/WIKI_HOME.md" # Wiki için referans
  content = replace(
    replace(
      file("${path.module}/sample_repo_docs/wiki.md"),
      "{{PROJECT_NAME}}", each.value.project_name
    ),
    "{{PROJECT_LEAD}}", each.value.lead
  )
  commit_message      = "Add wiki home documentation"
  overwrite_on_create = true

  lifecycle {
    ignore_changes = [content]
  }
}

# Local values for processing complex data structures
locals {
  # Map project names to their first repository (main repo)
  project_main_repos = {
    for project_name, project in var.projects :
    project_name => project.repositories[0].name
  }

  wiki_pages = {
    for project_name, project in var.projects :
    project_name => {
      repository = project.repositories[0].name
      content = replace(
        replace(
          file("${path.module}/sample_repo_docs/wiki.md"),
          "{{PROJECT_NAME}}", project_name
        ),
        "{{PROJECT_LEAD}}", project.lead
      )
    }
  }

  # Flatten repos from projects
  all_repos = flatten([
    for project_name, project in var.projects : [
      for repo in project.repositories : {
        project_name    = project_name
        repo_name       = repo.name
        description     = repo.description
        visibility      = repo.visibility
        lead            = project.lead
        team_permission = project.team_permission
      }
    ]
  ])

  # Flatten team memberships
  all_memberships = flatten([
    for project_name, project in var.projects : [
      for member in project.members : {
        project = project_name
        user    = member.username
        role    = member.role
      }
    ]
  ])
}