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
  "project-alpha" = {
    lead            = "flovearth"
    team_permission = "push"
    repositories = [
      {
        name        = "to-do-api"
        description = "API service for Project To-Do"
        visibility  = "public"
      },

      {
        name        = "to-do-web"
        description = "Web interface for Project To-Do"
        visibility  = "public"
      }
    ]
    members = [
      {
        username = "ismailaricioglu"
        role     = "maintainer"
      },
      {
        username = "hulyaoner"
        role     = "member"
      },
      {
        username = "lerkush"
        role     = "member"
      },
      {
        username = "flovearth"
        role     = "member"
      }
    ]
  }

  "project-beta" = {
    lead            = "ismailaricioglu"
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
        username = "lerkush"
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
        username = "egeren"
        role     = "member"
      }
    ]
  }

  "project-gamma" = {
    lead            = "egeren"
    team_permission = "triage"
    repositories = [
      {
        name        = "general-docs"
        description = "Documentation for Project General Docs"
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

  "Documentation" = {
    lead            = "flovearth"
    team_permission = "push"
    repositories = [
      {
        name        = "01-Documentation"
        description = "Topluluk için genel dokümantasyon"
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
        role     = "maintainer"
      },
      {
        username = "onurceylan"
        role     = "member"
      },
      {
        username = "UsainSasal"
        role     = "member"
      },
      {
        username = "egeren"
        role     = "member"
      },
      {
        username = "hulyaoner"
        role     = "member"
      },
      {
        username = "lerkush"
        role     = "member"
      },
    ]
  }
}