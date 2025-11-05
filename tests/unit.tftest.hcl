variables {
  projects = {
    "test-project" = {
      lead            = "test-lead"
      team_permission = "push"
      repositories = [
        { name = "repo1", description = "d1", visibility = "public" },
        { name = "repo2", description = "d2", visibility = "private" }
      ]
      members = [
        { username = "user1", role = "member" }
      ]
    }
  }
  github_organization = "test-org"
  github_token        = "test-token"
}

run "check_locals_all_repos_flattening" {
  command = plan

  assert {
    condition     = length(local.all_repos) == 2
    error_message = "The length of local.all_repos should have been 2, but it was ${length(local.all_repos)}."
  }

  assert {
    condition     = local.all_repos[0].repo_name == "repo1"
    error_message = "first repo's name shoud be repo1."
  }

  assert {
    condition     = local.all_repos[1].project_name == "test-project"
    error_message = "second repos's name should've be 'test-project'."
  }
}