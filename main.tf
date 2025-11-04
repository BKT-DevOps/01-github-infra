provider "github" {
  owner = var.github_organization
  token = var.github_token
}

# =============================
# TEAM OLUŞTURMA - Organizasyon Ekipleri
# =============================
# Her proje için ayrı takım oluşturur. Bu, ekip rollerinin merkezidir.
resource "github_team" "project" {
  for_each    = var.projects
  name        = each.key
  description = "${each.key} projesi geliştirme ekibi"
  privacy     = "closed"
}

# =============================
# REPO YÖNETİMİ - Proje Depoları
# =============================
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

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = false
  allow_auto_merge   = false
}

# =============================
# EKİP YETKİLENDİRMESİ
# =============================
# Takımın repolara erişim düzeyini belirler.
resource "github_team_repository" "access" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  team_id    = github_team.project[each.value.project_name].id
  repository = github_repository.repo[each.key].name
  permission = each.value.team_permission
}

# =============================
# TAKIM ÜYELERİ VE ROLLERİ
# =============================
# Üyeleri takımlara ekler ve rolleri (maintainer/member) atar.
resource "github_team_membership" "members" {
  for_each = { for m in local.all_memberships : "${m.project}-${m.user}" => m }

  team_id  = github_team.project[each.value.project].id
  username = each.value.user
  role     = each.value.role
}

# =============================
# PROJE LİDERLERİNE YÖNETİCİ YETKİSİ
# =============================
resource "github_repository_collaborator" "lead" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository = github_repository.repo[each.key].name
  username   = each.value.lead
  permission = "admin"
}

# =============================
# BRANCH OLUŞTURMA VE KORUMA
# =============================
# develop / release dalları oluşturur.
resource "github_branch" "develop" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository    = github_repository.repo[each.key].name
  branch        = "develop"
  source_branch = try(github_repository.repo[each.key].default_branch, "main")
}

resource "github_branch" "release" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository    = github_repository.repo[each.key].name
  branch        = "release"
  source_branch = try(github_repository.repo[each.key].default_branch, "main")
}

# Ana dal koruma kuralları
resource "github_branch_protection" "main" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository_id = github_repository.repo[each.key].node_id
  pattern       = "main"

  required_status_checks { strict = true }

  required_pull_request_reviews {
    required_approving_review_count = 1
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
  }

  enforce_admins         = false
  allows_deletions       = false
  allows_force_pushes    = false
  require_signed_commits = true
}

# =============================
# CODEOWNERS VE DOKÜMANTASYON
# =============================
resource "github_repository_file" "codeowners" {
  for_each = { for repo in local.all_repos : repo.repo_name => repo }

  repository = github_repository.repo[each.key].name
  branch     = "main"
  file       = ".github/CODEOWNERS"
  content    = "* @${each.value.lead}\n"
  commit_message = "Add CODEOWNERS file"
}

# =============================
# DOKÜMANTASYON DOSYALARI VE README
# =============================
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
  overwrite_on_create = true
}
