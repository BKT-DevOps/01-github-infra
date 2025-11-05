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

# -----------------------------------------------------------
# Access Matrix (Unified Team Roles & Repository Permissions)
# -----------------------------------------------------------

variable "access_matrix" {
  description = "Ekip rolleri ve repo erişim izinleri birleşik tanımı"
  type = map(object({
    role       = string
    permission = string
    description = optional(string)
  }))

  validation {
    condition = alltrue([
      for k, v in var.access_matrix :
      contains(["pull", "triage", "push", "maintain", "admin"], v.permission)
    ])
    error_message = "Permission must be one of: pull, triage, push, maintain, admin"
  }

  validation {
    condition = alltrue([
      for k, v in var.access_matrix :
      contains(["maintainer", "contributor", "reviewer", "community", "lead"], v.role)
    ])
    error_message = "Role must be one of: maintainer, contributor, reviewer, community, lead"
  }
}

# -----------------------------------------------------------
# END- Access Matrix (Unified Team Roles & Repository Permissions)
# -----------------------------------------------------------

# | Özellik                           | **Mevcut Model (`projects`)**                                                         | **Birleşik Model — “B” (`projects` + `access_matrix`)**                                                                      |
# | --------------------------------- | ------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
# | **Tanım Düzeyi**                  | Her proje için ayrı yapı. Her projede lead, üyeler, repo izinleri tek tek tanımlanır. | Roller, izinler ve anlamları sistem genelinde tek kez tanımlanır. Projeler bu referansları kullanır.                         |
# | **Kullanım Amacı**                | Proje bazında repository ve ekip yapılandırmasını belirler.                           | Tüm sistem için rol–izin politikasını yönetir; projeler sadece rol anahtarlarını kullanır.                                   |
# | **Değişkenlerin İçeriği**         | `projects` değişkeni: `{ lead, team_permission, repositories[], members[] }`          | `projects` + `access_matrix` birleşimi: `projects` rol referansları içerir, `access_matrix` bunların izin detaylarını tutar. |
# | **Tekrar**                        | Her proje `team_permission` ve `member.role` değerlerini tekrar yazar.                | Roller tek merkezden (`access_matrix`) tanımlanır; projelerde sadece anahtar kullanılır.                                     |
# | **İlişkili Terraform Kaynakları** | `github_team`, `github_repository`, `github_membership`                               | `github_team_repository`, `github_team_membership`, `github_repository`                                                      |
# | **Yönetilebilirlik**              | Kapsam dar, küçük ölçekli ekiplerde basit ama karmaşık yapılarda hantaldır.           | Merkezi yönetim sağlar; tüm roller/izinler tek yerde değiştirilebilir, büyük yapılarda ölçeklenir.                           |
# | **Kapsam (Scope)**                | Yalnızca proje düzeyi (örneğin tek repo grubu).                                       | Organizasyon genelinde (örneğin tüm alt repolar ve ekipler).                                                                 |
# | **Bakım ve Güncelleme**           | Yeni rol veya izin eklendiğinde tüm projelerde manuel düzenleme gerekir.              | Yeni rol eklendiğinde sadece `access_matrix` güncellenir, tüm projelere otomatik yansır.                                     |
# | **Okunabilirlik / Sadelik**       | Kod tekrarları yüksek, uzun tfvars dosyaları oluşur.                                  | Proje tanımları sadeleşir; `role = "reviewer"` gibi kısa referanslar yeterlidir.                                             |
# | **Ölçeklenebilirlik**             | Zayıf — her proje bağımsız tanımlandığı için büyüdükçe karmaşıklaşır.                 | Yüksek — merkezi roller sayesinde yüzlerce repo/ekip kolayca yönetilebilir.                                                  |
# | **Önerilen Kullanım Senaryosu**   | Küçük, kapalı ekipli özel projeler.                                                   | Açık kaynak, çok ekipli, sürekli büyüyen organizasyon yapıları.                                                              |
