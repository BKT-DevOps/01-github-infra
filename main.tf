#############################################
# GitHub Infrastructure - Unified Model
# Main Terraform Configuration
#############################################

provider "github" {
  owner = var.github_organization
  token = var.github_token
}

#############################################
# Locals - Unified Access Matrix
#############################################

locals {
  access_matrix = var.access_matrix

  # Rol tabanlı izin dönüşümü
  role_permission_map = {
    for role, info in local.access_matrix : role => info.permission
  }
}

#############################################
# TEAM CREATION PER PROJECT
#############################################

resource "github_team" "project" {
  for_each    = var.projects
  name        = each.key
  description = "${each.key} projesi geliştirme ekibi"
  privacy     = "closed"
}

#############################################
# REPOSITORY CREATION PER PROJECT
#############################################

resource "github_repository" "project_repo" {
  for_each = merge([
    for project_name, project in var.projects : {
      for repo in project.repositories :
      "${project_name}-${repo.name}" => {
        project_name = project_name
        repo         = repo
      }
    }
  ]...)

  name         = each.value.repo.name
  description  = each.value.repo.description
  visibility   = each.value.repo.visibility
  auto_init    = true
}

#############################################
# TEAM MEMBERS ASSIGNMENT
#############################################

resource "github_team_membership" "project_members" {
  for_each = merge([
    for project_name, project in var.projects : {
      for member in project.members :
      "${project_name}-${member.username}" => {
        project_name = project_name
        member       = member
      }
    }
  ]...)

  team_id  = github_team.project[each.value.project_name].id
  username = each.value.member.username
  role     = lookup(local.access_matrix, each.value.member.role, { role = "member" }).role
}

#############################################
# TEAM REPOSITORY PERMISSIONS
#############################################

resource "github_team_repository" "team_repo_access" {
  for_each = merge([
    for project_name, project in var.projects : {
      for repo in project.repositories :
      "${project_name}-${repo.name}" => {
        project_name = project_name
        repo_name    = repo.name
        permission   = project.team_permission
      }
    }
  ]...)

  team_id    = github_team.project[each.value.project_name].id
  repository = github_repository.project_repo["${each.value.project_name}-${each.value.repo_name}"].name
  permission = each.value.permission
}

#############################################
# OUTPUTS
#############################################

output "created_teams" {
  value = {
    for k, v in github_team.project : k => v.name
  }
}

output "created_repositories" {
  value = {
    for k, v in github_repository.project_repo : k => v.name
  }
}

output "team_memberships" {
  value = {
    for k, v in github_team_membership.project_members : k => {
      username = v.username
      role     = v.role
    }
  }
}

# | Özellik      | Eski Model         | Yeni Model                 |
# | ------------ | ------------------ | -------------------------- |
# | Satır Sayısı | ~407               | ~120                       |
# | Roller       | Kod içinde tanımlı | `tfvars` üzerinden dinamik |
# | Üyeler       | Tek tek resource   | Döngüyle işleniyor         |
# | Yönetim      | Kod bazlı          | Veri bazlı                 |
# | Güncelleme   | Kod değişikliği    | tfvars güncellemesi        |
