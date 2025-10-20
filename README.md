# Manage GitHub via Terraform and GitHub Actions Workflow

This project manages GitHub repositories infrastructure via Terraform for any organization, designed to **streamline contest organization** and **eliminate setup complexity**. 

**For Organizers**: This solution enables organizers to **easily create any required number of repositories** following **standardized configurations**, ensuring all teams/projects start with identical setups and security policies. Instead of manually creating and configuring repositories one by one, organizers can deploy entire infrastructure with a single merge to main branch.

**For Teams and Participants**: Team members and leaders can **focus entirely on their development tasks** rather than spending valuable time on time-consuming GitHub configurations, repository setup, and access management. All projects use the same baseline configuration, ensuring **standardised** and **consistent development environments**.

**For Future Organizations**: This project serves as a **reusable template and reference** for future projects or events, allowing organizers to quickly adapt and deploy infrastructure for different project formats, team sizes, and requirements.

The system creates and configures multiple team repositories with proper security controls, branch protection rules, and user access management through automated GitHub Actions workflows.

## Project Overview

This Terraform configuration manages:
- 5 GitHub repositories (team-1, team-2, team-3, team-4, team-5)
- User access management for each repository
- Branch protection rules for main, release, and develop branches
- Team lead approval requirements
- Security configurations
- **Automated deployment via GitHub Actions workflow**

## Automated Infrastructure Management

This repository uses **GitHub Actions** to automatically apply Terraform changes when code is merged to the main branch. The workflow provides:

- **Zero-touch deployment**: Changes are automatically applied without manual intervention
- **Pull Request workflow**: Create PRs for infrastructure changes, review, and merge
- **Automatic Terraform execution**: Workflow triggers on main branch merges
- **State management**: Terraform state is securely managed in the workflow
- **Multi-team support**: Single workflow manages all team repositories

## Test Stage - PR Protection

For enhanced safety and validation, this project implements **Terraform plan workflows** that run on every Pull Request against `dev`, `release`, and `main` branches:

### PR Validation Workflow
- **Terraform Plan**: Automatically runs `terraform plan` on every PR
- **Status Checks**: Branch protection requires successful plan validation
- **Merge Protection**: Failed plans prevent PR merging
- **Early Detection**: Catch configuration errors before they reach main branches

### Branch Protection Integration
Each protected branch (`main`, `release`, `develop`) requires:
- ✅ **Terraform Plan Success**: Plan must complete without errors
- ✅ **Code Review Approval**: Human review still required
- ✅ **Status Check Passing**: All automated checks must pass
- ❌ **Merge Blocking**: Failed plans automatically block merge

### Workflow Triggers
```yaml
on:
  pull_request:
    branches: [ main, release, develop ]
    paths:
      - '**.tf'
      - '**.tfvars'
      - '.github/workflows/terraform-*.yml'
```

### Test Stage Benefits
- **Prevent Broken Infrastructure**: Catch errors before deployment
- **Faster Feedback**: Immediate validation on PR creation
- **Reduced Risk**: No surprises when merging to main
- **Documentation**: Plan output shows exactly what will change
- **Compliance**: Ensures all changes follow Terraform best practices


## Repository Structure

Each team repository includes:
- **5 team members** with push access
- **1 team leader** with admin access and approval privileges
- **3 protected branches**: main, release, develop
- **Branch protection rules** requiring PR reviews
- **Security configurations** for the contest environment

## Branch Protection Strategy

### Main Branch
- Requires team leader approval
- Dismiss stale reviews when new commits are pushed
- **Require status checks to pass**: `Terraform Plan` must succeed
- Restrict pushes to admins only
- **Merge blocked on failed tests**: PRs cannot merge if Terraform plan fails

### Release Branch
- Requires one approval from any team member
- Dismiss stale reviews when new commits are pushed
- **Require status checks to pass**: `Terraform Plan` must succeed
- Allow force pushes by admins
- **Merge blocked on failed tests**: PRs cannot merge if Terraform plan fails

### Develop Branch
- Requires one approval from any team member
- **Require status checks to pass**: `Terraform Plan` must succeed
- Less restrictive for development workflow
- **Merge blocked on failed tests**: PRs cannot merge if Terraform plan fails

### Status Check Configuration

To enable the PR protection, configure these required status checks in each branch protection rule:

```
Required status checks:
- Terraform Plan ✅
- (other CI checks as needed)

Status check settings:
✅ Require status checks to pass before merging
✅ Require branches to be up to date before merging
```



## Two-Stage Security Deployment

For enhanced security, this project implements a **two-stage deployment approach** transitioning from PAT tokens to deploy keys:

### Stage 1: Initial Repository Creation (PAT Token)
1. **Repository Creation**: Use PAT token to create all team repositories via Terraform
2. **Initial Configuration**: Set up basic repository settings, branch protection, and user access
3. **Foundation Setup**: Establish the infrastructure baseline for all teams

### Stage 2: Enhanced Security (Deploy Keys)
1. **PAT Token Removal**: Remove PAT token from repository secrets for security
2. **Deploy Key Generation**: Manually create individual deploy keys for each team repository
3. **Public Key Storage**: Store public keys for each repository in this management repo
4. **Secure Workflow**: Configure GitHub Actions to use repository-specific deploy keys

### Security Benefits
- **Reduced Attack Surface**: No single PAT token with broad permissions
- **Repository Isolation**: Each team repository has its own dedicated deploy key
- **Granular Access**: Deploy keys provide write access only to specific repositories
- **Key Rotation**: Individual keys can be rotated without affecting other repositories
- **Audit Trail**: Each repository access is individually trackable

```

## Usage Instructions

### Prerequisites
1. GitHub repository with Actions enabled
2. Access to the target GitHub organization
3. **No local Terraform installation required** - everything runs in GitHub Actions
4. SSH key generation tools (for deploy keys)

## Stage 1: Initial Setup with PAT Token

### 1.1 Repository Secrets Configuration (Initial)
   
Configure the following secrets in your GitHub repository settings:
```
GITHUB_TOKEN          # GitHub PAT with repo and org permissions
GITHUB_ORGANIZATION   # Your GitHub organization name
TF_VAR_github_token   # Same as GITHUB_TOKEN for Terraform
```

### 1.2 Team Configuration Files
   
Create team-specific variable files (e.g., `team-1.tfvars`, `team-2.tfvars`):
```hcl
# team-1.tfvars
team_number = 1
team_leader = "team1-leader-username"
team_members = [
  "team1-member1",
  "team1-member2", 
  "team1-member3",
  "team1-member4",
  "team1-member5"
]
```

### 1.3 Initial Deployment
1. **Create repositories**: Run initial workflow to create all team repositories
2. **Verify creation**: Ensure all 5 team repositories are created with proper settings
3. **Test functionality**: Verify branch protection rules and user access

## Stage 2: Transition to Deploy Keys (Enhanced Security)

### 2.1 Remove PAT Token
```bash
# Remove these secrets from repository settings:
# - GITHUB_TOKEN
# - TF_VAR_github_token
```

### 2.2 Generate Deploy Keys for Each Repository

For each team repository, generate SSH key pairs:

```bash
# Generate deploy keys for all teams (one-liner)
for i in {1..5}; do ssh-keygen -t ed25519 -f ./keys/team-${i}-deploy-key -C "deploy-key-team-${i}" -N ""; done
```

### 2.3 Configure Deploy Keys in Team Repositories

For each team repository:
1. **Navigate to repository settings** → Deploy keys
2. **Add deploy key** with write access
3. **Paste the public key** content (`.pub` file)
4. **Enable write access** for the deploy key

### 2.4 Store Private Keys as Repository Secrets

Add the private keys as secrets in this management repository:
```
TEAM_1_DEPLOY_KEY     # Content of team-1-deploy-key (private key)
TEAM_2_DEPLOY_KEY     # Content of team-2-deploy-key (private key)
TEAM_3_DEPLOY_KEY     # Content of team-3-deploy-key (private key)
TEAM_4_DEPLOY_KEY     # Content of team-4-deploy-key (private key)
TEAM_5_DEPLOY_KEY     # Content of team-5-deploy-key (private key)
GITHUB_ORGANIZATION   # Keep this secret
```

### 2.5 Store Public Keys in Repository

Create a `deploy-keys/` directory and store public keys:
```
deploy-keys/
├── team-1-deploy-key.pub
├── team-2-deploy-key.pub
├── team-3-deploy-key.pub
├── team-4-deploy-key.pub
└── team-5-deploy-key.pub
```

### Making Changes (Automated Workflow)

1. **Create a feature branch**
   ```bash
   git checkout -b feature/update-team-1-members
   ```

2. **Make your infrastructure changes**
   - Update Terraform configuration files
   - Modify team member lists in `.tfvars` files
   - Add new team repositories
   - Update branch protection rules

3. **Create a Pull Request**
   ```bash
   git add .
   git commit -m "Update team-1 member list"
   git push origin feature/update-team-1-members
   ```
   Then create a PR through GitHub UI

4. **Automated Testing (Test Stage)**
   - **Terraform Plan runs automatically** on PR creation
   - **Plan results posted as PR comment** showing what will change
   - **Status check must pass** before merge is allowed
   - **Fix any plan failures** before proceeding

5. **Review and Merge**
   - Review the proposed changes in the PR
   - **Check Terraform plan output** in PR comments
   - Ensure **status checks are green** ✅
   - **Merge to target branch** (develop/release/main)
   - **GitHub Actions automatically applies changes** (main branch only)
   Then create a PR through GitHub UI

4. **Review and Merge**
   - Review the proposed changes in the PR
   - Check Terraform plan output (if plan workflow is enabled)
   - **Merge to main branch**
   - **GitHub Actions automatically applies changes**

### Workflow Trigger

The GitHub Actions workflow automatically triggers when:
- Code is **merged to the main branch**
- **No manual terraform commands needed**
- **No local setup required**
- All changes are applied automatically to the target repositories

### GitHub Actions Workflow Example

The workflow automatically manages all team repositories with proper testing on PRs. Here's the complete workflow file (`.github/workflows/terraform.yml`):

```yaml
name: 'Terraform Infrastructure'

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main, release, develop ]
    paths:
      - '**.tf'
      - '**.tfvars'
      - '.github/workflows/terraform-*.yml'

jobs:
  terraform-plan:
    name: 'Terraform Plan'
    runs-on: ubuntu-latest
    if: github.event_name == 'pull_request'
    
    steps:
    - name: Checkout
      uses: actions/checkout@v4

    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v3
      with:
        terraform_version: 1.6.0

    - name: Terraform Init
      run: terraform init
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

    - name: Terraform Validate
      run: terraform validate

    - name: Terraform Plan
      id: plan
      run: terraform plan -no-color -detailed-exitcode
      env:
        GITHUB_TOKEN: ${{ secrets.TF_VAR_github_token }}
        TF_VAR_github_organization: ${{ secrets.GITHUB_ORGANIZATION }}
      continue-on-error: true

    - name: Comment PR with Plan
      uses: actions/github-script@v7
      if: github.event_name == 'pull_request'
      env:
        PLAN: "terraform\n${{ steps.plan.outputs.stdout }}"
      with:
        github-token: ${{ secrets.GITHUB_TOKEN }}
        script: |
          const output = `#### Terraform Plan 📖\`${{ steps.plan.outcome }}\`

          <details><summary>Show Plan</summary>

          \`\`\`\n
          ${process.env.PLAN}
          \`\`\`

          </details>

          *Pusher: @${{ github.actor }}, Action: \`${{ github.event_name }}\`, Workflow: \`${{ github.workflow }}\`*`;

          github.rest.issues.createComment({
            issue_number: context.issue.number,
            owner: context.repo.owner,
            repo: context.repo.repo,
            body: output
          })

    - name: Check Plan Status
      if: steps.plan.outcome == 'failure'
      run: |
        echo "❌ Terraform plan failed!"
        echo "This PR cannot be merged until the plan succeeds."
        exit 1

  terraform-apply:
    name: 'Terraform Apply'
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main' && github.event_name == 'push'
    
    steps:
    - name: Checkout
      uses: actions/checkout@v4

    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v3
      with:
        terraform_version: 1.6.0

    - name: Terraform Init
      run: terraform init
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

    - name: Terraform Apply
      run: terraform apply -auto-approve
      env:
        GITHUB_TOKEN: ${{ secrets.TF_VAR_github_token }}
        TF_VAR_github_organization: ${{ secrets.GITHUB_ORGANIZATION }}
        TF_VAR_github_organization: ${{ secrets.GITHUB_ORGANIZATION }}
```

### Managing Multiple Teams

All team repositories are managed through this single workflow:

1. **Single configuration** manages all 5 teams
2. **Automatic deployment** on main branch merge
3. **No manual intervention** required
4. **Centralized management** of all team infrastructure

The workflow will automatically:
- Create/update repositories for team-1 through team-5
- Apply user access changes
- Update branch protection rules
- Manage security settings

## Security Considerations

- Use environment variables for sensitive data like GitHub tokens
- Enable branch protection rules before adding team members
- Regularly review repository access and permissions
- Consider using GitHub Teams for easier user management
- Enable security alerts and dependency scanning

## File Structure

```
├── .github/
│   └── workflows/
│       └── terraform.yml        # Main workflow with PR testing
├── main.tf                      # Main Terraform configuration
├── variables.tf                 # Variable definitions
├── outputs.tf                   # Output definitions  
├── team-1.tfvars               # Team 1 configuration
├── team-2.tfvars               # Team 2 configuration
├── team-3.tfvars               # Team 3 configuration
├── team-4.tfvars               # Team 4 configuration
├── team-5.tfvars               # Team 5 configuration
├── templates/
│   └── team_readme.md          # Template for team repository README
├── .gitignore                  # Excludes sensitive files, private keys and temp files
└── README.md                   # This file
```


## Deploy Keys Workflow Example (Stage 2)

Here's an example workflow file for Stage 2 using deploy keys (`.github/workflows/terraform-stage2.yml`):

```yaml
name: 'Terraform Infrastructure - Deploy Keys'

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  terraform:
    name: 'Terraform with Deploy Keys'
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout
      uses: actions/checkout@v4

    - name: Setup SSH Agent
      uses: webfactory/ssh-agent@v0.7.0
      with:
        ssh-private-key: |
          ${{ secrets.TEAM_1_DEPLOY_KEY }}
          ${{ secrets.TEAM_2_DEPLOY_KEY }}
          ${{ secrets.TEAM_3_DEPLOY_KEY }}
          ${{ secrets.TEAM_4_DEPLOY_KEY }}
          ${{ secrets.TEAM_5_DEPLOY_KEY }}

    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v3
      with:
        terraform_version: 1.6.0

    - name: Configure Git for SSH
      run: |
        git config --global url."git@github.com:".insteadOf "https://github.com/"

    - name: Terraform Init
      run: terraform init
      env:
        TF_VAR_github_organization: ${{ secrets.GITHUB_ORGANIZATION }}

    - name: Terraform Plan
      run: terraform plan -no-color
      env:
        TF_VAR_github_organization: ${{ secrets.GITHUB_ORGANIZATION }}

    - name: Terraform Apply
      if: github.ref == 'refs/heads/main' && github.event_name == 'push'
      run: terraform apply -auto-approve
      env:
        TF_VAR_github_organization: ${{ secrets.GITHUB_ORGANIZATION }}
```

## Workflow Benefits

### For Administrators
- **No local setup required** - everything runs in GitHub Actions
- **Audit trail** - all changes tracked through Git history
- **Review process** - changes reviewed via Pull Requests
- **Rollback capability** - easy to revert through Git
- **Centralized management** - single repository manages all teams

### For Team Management
- **Easy member updates** - just edit `.tfvars` files and merge
- **Consistent configuration** - all teams follow same security rules
- **Automated deployment** - no manual terraform commands
- **Version controlled** - all infrastructure changes are tracked

### Security Benefits (Stage 2 - Deploy Keys)
- **Eliminated PAT token exposure** - no broad-access tokens stored
- **Repository-specific access** - each deploy key works only for its target repo
- **Reduced blast radius** - compromise of one key doesn't affect other repositories
- **Granular permissions** - deploy keys have write access only to specific repositories
- **Key rotation capability** - individual keys can be rotated independently
- **No user account dependency** - deploy keys work independent of user accounts
- **Audit isolation** - each repository access is individually logged and trackable

### Migration Benefits
- **Phased transition** - gradual move from PAT to deploy keys
- **Zero downtime** - repositories remain functional during transition
- **Rollback option** - can revert to PAT tokens if needed during migration
- **Testing capability** - validate deploy key setup before removing PAT tokens

## Contributing

1. **Fork the repository** (if external contributor)
2. **Create a feature branch** for your changes
   ```bash
   git checkout -b feature/description-of-change
   ```
3. **Make your infrastructure changes**
   - Update Terraform configurations
   - Modify team configurations in `.tfvars` files
   - Update documentation if needed
4. **Submit a pull request**
   - PR will trigger plan workflow (if configured)
   - Review the planned changes
   - **Merge to main triggers automatic deployment**

## Troubleshooting

### Common Issues

**Stage 1 Issues (PAT Token):**
- Verify `GITHUB_TOKEN` secret has correct permissions
- Ensure token has `repo` and organization access
- Check token hasn't expired or been revoked

**Stage 2 Issues (Deploy Keys):**
- Verify deploy keys are properly configured in each repository
- Ensure private keys are correctly stored as repository secrets
- Check SSH agent setup in GitHub Actions workflow
- Verify public keys match the private keys stored in secrets

**Migration Issues:**
- **Deploy key not working**: Verify public key was added to correct repository with write permissions
- **SSH connection failed**: Check if private key format is correct (OpenSSH format)
- **Authentication failed**: Ensure git is configured to use SSH instead of HTTPS

**Terraform state conflicts:**
- Use Terraform remote state (S3, Terraform Cloud, etc.)
- Configure state locking to prevent concurrent runs

**Team member not added:**
- Verify GitHub username exists and is correct
- Check if user has enabled organization membership visibility

### Migration Checklist

**Before removing PAT token:**
1. ✅ All deploy keys generated and stored
2. ✅ Public keys added to each team repository with write access
3. ✅ Private keys stored as repository secrets
4. ✅ Stage 2 workflow tested successfully
5. ✅ Terraform plan/apply works with deploy keys

**Deploy Key Validation:**
```bash
# Test deploy key access for team-1
ssh -T -i ./keys/team-1-deploy-key git@github.com

# Should return: "Hi [org]/team-1! You've successfully authenticated..."
```

## License

This project is licensed under the Apache 2.0  License - see the [LICENSE](LICENSE) file for details.
