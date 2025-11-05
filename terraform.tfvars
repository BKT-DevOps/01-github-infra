# GitHub Configuration
github_organization = "BKT-DevOps"

# Example Project Configuration
# "project-alpha" = {  # "project-alpha" takım ismi olacaktır
#   lead            = "flovearth" # proje lideri
#   team_permission = "push" # takım izni
#   repositories = [ # proje repoları
#     {
#       name              = "to-do-api" # repo ismi
#       description       = "API service for Project To-Do" # repo açıklaması
#       visibility        = "public" # repo görünürlüğü
#     }
#   ]
#   members = [ # proje üyeleri
#     {
#       username = "flovearth" # üye GitHub kullanıcı adı
#       role     = "maintainer" # üye rolü (maintainer repo yöneticisi, member normal üye)
#     },
#     {
#       username = "hulyaoner" # üye GitHub kullanıcı adı
#       role     = "member" # üye rolü (maintainer repo yöneticisi, member normal üye)
#     },
#     {
#       username = "lerkush"
#       role     = "member"
#     },
#     {
#       username = "ismailaricioglu"
#       role     = "member"
#     }  # aynı formatta diğer üyeler eklenebilir 
#   ]
# }

# Projects Configuration
projects = {
  "InfraCoders" = {
    lead            = "flovearth"
    team_permission = "push"
    repositories = [
      {
        name        = "project-terraform-github"
        description = "Terraform ile GitHub Repolarının Otomatik yönetimi"
        visibility  = "public"
      },

    ]
    members = [
      {
        username = "barisbutun"
        role     = "member"
      },
      {
        username = "hakanceran64"
        role     = "member"
      },
      {
        username = "hulyaoner"
        role     = "member"
      },
      {
        username = "ismailaricioglu"
        role     = "member"
      },
      {
        username = "karalarmehmet"
        role     = "member"
      },
      {
        username = "kheif"
        role     = "member"
      },
      {
        username = "purfatih"
        role     = "member"
      },
      {
        username = "seyid12"
        role     = "member"
      },
      {
        username = "Shamsiaa"
        role     = "member"
      },
      {
        username = "slymanmrcan"
        role     = "member"
      }
    ]
  }

  "kovan" = {
    lead            = "hakanceran64"
    team_permission = "push"
    repositories = [
      {
        name        = "communication-service"
        description = "Core service for Project Communication"
        visibility  = "public"
      }
    ]
    members = [
      {
        username = "flovearth"
        role     = "maintainer"
      },
      {
        username = "ismailaricioglu"
        role     = "member"
      },
      {
        username = "hulyaoner"
        role     = "member"
      },
      {
        username = "slymanmrcan"
        role     = "member"
      },
      {
        username = "barisbutun"
        role     = "member"
      }
    ]
  }

  "project-test" = {
    lead            = "ismailaricioglu"
    team_permission = "push"
    repositories = [
      {
        name        = "test-repo"
        description = "Test repository for demo purposes"
        visibility  = "public"
      }
    ]
    members = [
      {
        username = "egeren"
        role     = "maintainer"
      },
      {
        username = "UsainSasal"
        role     = "member"
      },
      {
        username = "onurceylan"
        role     = "member"
      }
    ]
  }

  # "Documentation" = {
  #   lead            = "flovearth"
  #   team_permission = "push"
  #   repositories = [
  #     {
  #       name        = "01-Documentation"
  #       description = "Topluluk için genel dokümantasyon"
  #       visibility  = "public"
  #     }
  #   ]
  #   members = [
  #     {
  #       username = "flovearth"
  #       role     = "maintainer"
  #     },
  #     {
  #       username = "ismailaricioglu"
  #       role     = "maintainer"
  #     },
  #     {
  #       username = "onurceylan"
  #       role     = "member"
  #     },
  #     {
  #       username = "UsainSasal"
  #       role     = "member"
  #     },
  #     {
  #       username = "egeren"
  #       role     = "member"
  #     },
  #     {
  #       username = "hulyaoner"
  #       role     = "member"
  #     },
  #     {
  #       username = "lerkush"
  #       role     = "member"
  #     },
  #   ]
  # }
}
