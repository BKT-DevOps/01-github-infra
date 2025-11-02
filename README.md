
<img width="1536" height="1024" alt="team_logo" src="https://github.com/user-attachments/assets/f59340f1-9ecd-4ead-9091-bc853bc50924" />

# GitHub Organizasyonları için Terraform ile Repo, Takım ve Kullanıcı Yönetimi Projesi

Bu Terraform konfigürasyonu, proje yönetimi için takım tabanlı bir yapıyla GitHub organizasyonunu yönetir. Kamuya açık topluluklar için tasarlanmıştır; projeler özel takımlar ve repolar ile organize edilir.


## Mimari Genel Bakış

### Temel Kavramlar

- **Her Proje için Bir Takım**: Her proje için ayrı bir GitHub takımı oluşturulur.
- **Takım Tabanlı Erişim**: Takımlar, proje repolarına uygun izinlerle atanır.
- **Proje Liderleri**: Her projenin, tüm proje repolarına admin erişimi olan bir lideri vardır.
- **Branch Koruması**: Main branch korumalıdır ve proje lideri onayı gerektirir.
- **CODEOWNERS**: Proje liderlerinin değişiklikleri onaylamasını sağlamak için otomatik olarak oluşturulur.


### Yapı

```
Organizasyon
├── Proje Alpha (Takım)
│   ├── alpha-api (repo)
│   ├── alpha-web (repo)
│   └── Üyeler: alice (lider), bob, charlie
├── Proje Beta (Takım)
│   ├── beta-service (repo)
│   └── Üyeler: diana (lider), eve, frank
└── Proje Gamma (Takım)
  ├── gamma-docs (repo)
  └── Üyeler: grace (lider), henry
```


# Özellikler

- ✅ **Takım Yönetimi**: Her proje için otomatik takım oluşturma.
- ✅ **Branch Otomasyonu**: Her yeni projede otomatik olarak `main`, `release`, `develop` branch'ları açılır.
- ✅ **Repo Yönetimi**: Proje başına birden fazla repo desteği.
- ✅ **Erişim Kontrolü**: Rol tabanlı izinler (lider = admin, üyeler = push/triage).
- ✅ **Branch Koruması**: Main branch için koruma ve onay gereksinimi.
- ✅ **Dokümantasyon**: Otomatik proje ve takım dokümantasyonu.
- ✅ **Issue Yönetimi**: Etiketli ilk kurulum issue'u.

- ✅ **CODEOWNERS**: Kod inceleme gereksinimi için otomatik dosya oluşturma (isteğe bağlı).
- ✅ **Esnek Roller**: Proje bazında farklı izin seviyeleri.
- ✅ **Çoklu Proje Desteği**: Kullanıcılar birden fazla projede farklı rollerle yer alabilir.

## Dokümantasyon


Her repoda bir `docs/` klasörü oluşturulur. Bu klasör örnek dokümantasyonu içerir. Takım liderleri ve üyeleri bu örnek belgelerden yararlanarak kendi özgün belgelerini oluşturabilirler.


## Konfigürasyon Referansı

### Proje Konfigürasyonu


Her proje için `projects` haritasında aşağıdaki alanlar desteklenir:

| Alan | Tip | Açıklama | Seçenekler |
|------|-----|----------|------------|
| `lead` | string | Proje liderinin GitHub kullanıcı adı | Geçerli bir GitHub kullanıcı adı |
| `team_permission` | string | Takım üyeleri için temel izin | `pull`, `triage`, `push`, `maintain` |
| `repositories` | list | Proje için repo listesi | Repo Konfigürasyonu |
| `members` | list | Takım üyeleri listesi | Üye Konfigürasyonu |

### Repo Konfigürasyonu

| Alan | Tip | Açıklama | Seçenekler |
|------|-----|----------|------------|
| `name` | string | Repo adı | Geçerli bir repo adı |
| `description` | string | Repo açıklaması | Herhangi bir metin |
| `visibility` | string | Repo görünürlüğü | `public`, `private` |
| `create_codeowners` | bool | CODEOWNERS dosyası oluşturulsun mu | `true`, `false` |

### Üye Konfigürasyonu

| Alan | Tip | Açıklama | Seçenekler |
|------|-----|----------|------------|
| `username` | string | GitHub kullanıcı adı | Geçerli bir GitHub kullanıcı adı |
| `role` | string | Takım rolü | `member`, `maintainer` |

## İzin Matrisi

| Rol | Repo Erişimi | Takım Yönetimi | Branch Koruması |
|-----|--------------|---------------|-----------------|
| **Proje Lideri** | Admin | Takımı yönetebilir | Korumayı aşabilir (konfigüre edilebilir) |
| **Takım Sorumlusu** | `team_permission`'a göre | Üye ekleyip çıkarabilir | Korumaya tabidir |
| **Takım Üyesi** | `team_permission`'a göre | Takımı yönetemez | Korumaya tabidir |

## Branch Koruma Kuralları

Tüm repolarda `main` branch otomatik olarak aşağıdaki kurallarla korunur:


- ✅ Pull request incelemesi gereklidir (en az 1 onay).
- ✅ Kod sahibi incelemesi gereklidir (CODEOWNERS ile).
- ✅ Yeni commit geldiğinde eski onaylar iptal edilir.
- ✅ Durum kontrolleri güncel olmalıdır.
- ❌ Adminler için kısıtlamalar esnek olması için devre dışı.

## En İyi Uygulamalar


### 1. Takım İzinleri

- Sadece dokümantasyon projeleri için `triage` kullanın.
- Aktif geliştirme projeleri için `push` kullanın.
- Daha fazla kontrol gerektiren üst düzey üyeler için `maintain` kullanın.


### 2. Proje Yapısı

- İlgili repoları aynı projede tutun.
- Proje adlarını açıklayıcı ve gerçek projeyi yansıtacak şekilde seçin.
- Aktif katılım gösteren, net proje liderleri atayın.


### 3. Güvenlik

- GitHub kişisel erişim anahtarlarını düzenli olarak değiştirin.
- Takım izinlerinde en az ayrıcalık ilkesini uygulayın.


### 4. Repo Yönetimi

- Açık kaynak topluluk projeleri için public görünürlük kullanın.
- Repo açıklamalarını net ve bilgilendirici tutun.

## GitHub Actions: Otomatik Terraform Uygulaması


Bu projede, ana dalda (main branch) yapılan her değişiklik sonrasında GitHub Actions otomasyonu devreye girer ve Terraform değişiklikleri otomatik olarak uygulanır.

- Herhangi bir pull request ana dala (main) birleştirildiğinde, ilgili Terraform kodu otomatik olarak çalıştırılır ve altyapı güncellenir.
- Ek bir manuel işlem gerektirmez; değişiklikler doğrudan organizasyon ortamına yansır.
- Otomasyonun durumu ve çıktıları GitHub Actions sekmesinden takip edilebilir.
- Otomatik uygulama sayesinde altyapı değişiklikleri hızlı, güvenli ve izlenebilir şekilde yönetilir. Tüm değişiklikler için kod incelemesi ve onay mekanizması (CODEOWNERS, branch protection) devrededir.

---

## İleri Seviye Kullanım

### Yeni Proje Ekleme


1. `terraform.tfvars` dosyanıza projeyi ekleyin:


```hcl
projects = {

  ...mevcut projeler...
  "yeni-proje" = {
    lead            = "yeni-lider-kullanici"
    team_permission = "push"
    repositories = [
      {
        name              = "yeni-proje-repo" # repo ismi
        description       = "Yeni proje için repo" # repo açıklaması
        visibility        = "public" # repo görünürlüğü
        create_codeowners = true
      }
    ]
    members = [
      {
        username = "yeni-lider-kullanici"
        role     = "maintainer"
      }
    ]
  }
}
```


2. Geri kalan işlemleri GitHub Actions otomasyonu halleder!

### Proje Silme


⚠️ **Uyarı**: Bu işlem takımları siler, repo erişimini kaldırır ve başka yerde referanslanmayan repoları silebilir.


1. Projeyi `terraform.tfvars` dosyasından çıkarın.
2. Geri kalan işlemleri GitHub Actions otomasyonu halleder!

### Projeler Arası İşbirliği Yönetimi


Kullanıcılar birden fazla projede farklı rollerle yer alabilir:


```hcl
  # "alice" proje-alpha'nın lideri, proje-beta'nın üyesi
  # Aşağıda örnek açıklamalar ile birlikte iki proje tanımı gösterilmiştir:
projects = {
  "proje-alpha" = { # "proje-alpha" takım ismi olacaktır
    lead = "alice" # proje lideri
    members = [
      { username = "alice", role = "maintainer" } # üye rolü (maintainer repo yöneticisi, member normal üye)
    ]
  }
  "proje-beta" = { # "proje-beta" takım ismi olacaktır
    lead = "bob" # proje lideri
    members = [
      { username = "bob", role = "maintainer" }, # üye rolü
      { username = "alice", role = "member" }    # üye rolü
    ]
  }
}
```


## Sorun Giderme


### Sık Karşılaşılan Sorunlar


1. **İzin Reddedildi**: GitHub token'ınızın `admin:org` yetkisine sahip olduğundan emin olun.
2. **Kullanıcı Bulunamadı**: Tüm kullanıcı adlarının GitHub'da mevcut olduğundan emin olun.
3. **Repo Zaten Var**: Repo adları organizasyonda benzersiz olmalıdır.
4. **Takım Adı Çakışması**: Takım adları organizasyonda benzersiz olmalıdır.


## Güvenlik Notları


1. **Token Güvenliği**: GitHub token'larını asla versiyon kontrolüne eklemeyin.
2. **State Dosyası**: Terraform state dosyası hassas bilgi içerebilir - güvenli saklayın.
3. **Erişim Kontrolü**: Takım üyeliklerini ve izinleri düzenli olarak gözden geçirin.
4. **Denetim Logları**: Yetkisiz değişiklikler için GitHub denetim loglarını izleyin.

## Katkı


PR açabilir ve issue oluşturabilirsiniz.

## Lisans


Bu proje MIT Lisansı ile lisanslanmıştır - detaylar için LICENSE dosyasına bakınız.

---

# GitHub Organization Management via Terraform

This Terraform configuration manages a GitHub organization with a team-based structure for project management. It's designed for public communities where projects are organized with dedicated teams and repositories.

## Architecture Overview

### Core Concepts

- **One Team per Project**: Each project gets its own GitHub team
- **Team-based Access**: Teams are assigned to project repositories with appropriate permissions
- **Project Leads**: Each project has a designated lead with admin access to all project repositories
- **Branch Protection**: Main branch is protected and requires code owner approval
- **CODEOWNERS**: Automatically created to ensure project leads approve changes

### Structure

```
Organization
├── Project Alpha (Team)
│   ├── alpha-api (Repository)
│   ├── alpha-web (Repository)
│   └── Members: alice (lead), bob, charlie
├── Project Beta (Team)
│   ├── beta-service (Repository)
│   └── Members: diana (lead), eve, frank
└── Project Gamma (Team)
    ├── gamma-docs (Repository)
    └── Members: grace (lead), henry
```

# Features

- ✅ **Team Management**: Automatic team creation per project
- ✅ **Branch Automation**: Each new project automatically creates `main`, `release`, and `develop` branches
- ✅ **Repository Management**: Multiple repos per project support
- ✅ **Access Control**: Role-based permissions (lead = admin, members = push/triage)
- ✅ **Branch Protection**: Main branch protection with required reviews
- ✅ **Documentation**: Automatic project and team documentation creation
- ✅ **Issue Management**: Initial setup issue with proper labels
- ✅ **CODEOWNERS**: Automatic generation for code review requirements (optional)
- ✅ **Flexible Roles**: Different permission levels per project
- ✅ **Multi-project Support**: Users can be in multiple projects with different roles

## Documentation

Each repository automatically gets comprehensive documentation in the `docs/` folder and an enhanced README.

## Configuration Reference

### Project Configuration

Each project in the `projects` map supports:

| Field | Type | Description | Options |
|-------|------|-------------|---------|
| `lead` | string | GitHub username of project lead | Any valid GitHub username |
| `team_permission` | string | Base permission for team members | `pull`, `triage`, `push`, `maintain` |
| `repositories` | list | List of repositories for this project | See Repository Configuration |
| `members` | list | List of team members | See Member Configuration |

### Repository Configuration

| Field | Type | Description | Options |
|-------|------|-------------|---------|
| `name` | string | Repository name | Any valid repository name |
| `description` | string | Repository description | Any string |
| `visibility` | string | Repository visibility | `public`, `private` |
| `create_codeowners` | bool | Whether to create CODEOWNERS file | `true`, `false` |

### Member Configuration

| Field | Type | Description | Options |
|-------|------|-------------|---------|
| `username` | string | GitHub username | Any valid GitHub username |
| `role` | string | Team role | `member`, `maintainer` |

## Permission Matrix

| Role | Repository Access | Team Management | Branch Protection |
|------|------------------|-----------------|-------------------|
| **Project Lead** | Admin | Can manage team | Bypass protection (configurable) |
| **Team Maintainer** | Based on `team_permission` | Can add/remove members | Subject to protection |
| **Team Member** | Based on `team_permission` | Cannot manage team | Subject to protection |

## Branch Protection Rules

All repositories automatically get branch protection on `main` with:

- ✅ Required pull request reviews (1 approval minimum)
- ✅ Require code owner reviews (via CODEOWNERS)
- ✅ Dismiss stale reviews when new commits are pushed
- ✅ Require status checks to be up to date
- ❌ Enforce restrictions for administrators (disabled for flexibility)

## Best Practices

### 1. Team Permissions

- Use `triage` for documentation-only projects
- Use `push` for active development projects
- Use `maintain` for senior team members who need more control

### 2. Project Structure

- Keep related repositories in the same project
- Use descriptive project names that reflect the actual project
- Assign clear project leads who are actively involved

### 3. Security

- Regularly rotate GitHub personal access tokens
- Use principle of least privilege for team permissions

### 4. Repository Management

- Enable CODEOWNERS for code review requirements
- Use public visibility for open-source community projects
- Keep repository descriptions clear and informative

## GitHub Actions: Automatic Terraform Apply

This project uses GitHub Actions automation to apply Terraform changes automatically whenever a change is merged into the `main` branch.

- When a pull request is merged to `main`, GitHub Actions will run and apply the Terraform code automatically.
- No manual steps are required; infrastructure changes are deployed directly to the cloud/organization environment.
- You can monitor the automation status and logs in the GitHub Actions tab.

**Note:** This automation ensures infrastructure changes are managed quickly, securely, and in a fully auditable way. All changes are subject to code review and approval mechanisms (CODEOWNERS, branch protection).

---

## Advanced Usage

### Adding a New Project

1. Add the project to your `terraform.tfvars`:

```hcl
projects = {
  # ... existing projects ...
  "new-project" = {
    lead            = "new-lead-username"
    team_permission = "push"
    repositories = [
      {
        name              = "new-project-repo"
        description       = "Repository for new project"
        visibility        = "public"
        create_codeowners = true
      }
    ]
    members = [
      {
        username = "new-lead-username"
        role     = "maintainer"
      }
    ]
  }
}
```

2. GitHub Actions Automation will do the rest!

### Removing a Project

⚠️ **Warning**: This will delete teams, remove repository access, and potentially delete repositories if they're not referenced elsewhere.

1. Remove the project from `terraform.tfvars`
2. GitHub Actions Automation will do the rest!

### Managing Cross-Project Collaboration

Users can be members of multiple projects with different roles:

```hcl
# User "alice" is lead of project-alpha and member of project-beta
projects = {
  "project-alpha" = {
    lead = "alice"
    members = [
      { username = "alice", role = "maintainer" }
    ]
  }
  "project-beta" = {
    lead = "bob"
    members = [
      { username = "bob", role = "maintainer" },
      { username = "alice", role = "member" }
    ]
  }
}
```

## Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure your GitHub token has `admin:org` scope
2. **User Not Found**: Verify all usernames exist on GitHub
3. **Repository Exists**: Repository names must be unique in the organization
4. **Team Name Conflicts**: Team names must be unique in the organization

## Security Considerations

1. **Token Security**: Never commit GitHub tokens to version control
2. **State File**: Terraform state may contain sensitive information - store securely
3. **Access Control**: Regularly review team memberships and permissions
4. **Audit Logging**: Monitor GitHub audit logs for unauthorized changes

## Contributing

Please feel free to raise a PR and create issue.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
