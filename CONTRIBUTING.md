# Katkıda Bulunma Rehberi | Contributing Guide
<details>
<summary><strong>🇹🇷 Türkçe</strong></summary>

## Katkıda Bulunma

BKT-DevOps topluluğuna katkıda bulunmak istediğiniz için teşekkür ederiz! 🎉

### 🚀 Hızlı Başlangıç

#### Gereksinimler
- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [GitHub Personal Access Token](https://github.com/settings/tokens)
- Git

#### Kurulum
```bash
# Repository'yi fork edin ve clone edin
git clone https://github.com/YOUR-USERNAME/01-github-infra.git
cd 01-github-infra

# Terraform'u başlatın
terraform init

# Token'ınızı ayarlayın
export TF_VAR_github_token="ghp_your_token"
```

### 📋 Katkı Süreci

#### 1. Issue Oluşturun
Yeni özellik veya hata bildirimi için issue açın.

#### 2. Branch Oluşturun
```bash
git checkout -b feature/yeni-ozellik
# veya
git checkout -b bugfix/hata-duzeltmesi
```

**Branch İsimlendirme:**
- `feature/` - Yeni özellikler
- `bugfix/` - Hata düzeltmeleri
- `docs/` - Dokümantasyon
- `refactor/` - Kod iyileştirme

#### 3. Değişiklik Yapın
```bash
# Kodunuzu yazın ve format edin
terraform fmt
terraform validate
terraform plan
```

#### 4. Commit Atın
```bash
# Anlamlı commit mesajları
git commit -m "feat: add wiki page creation"
git commit -m "fix: correct team permission"
git commit -m "docs: update README"
```

**Commit Ön Ekleri:**
- `feat:` - Yeni özellik
- `fix:` - Hata düzeltmesi
- `docs:` - Dokümantasyon
- `refactor:` - Kod iyileştirme
- `chore:` - Diğer

#### 5. Pull Request Gönderin
```bash
git push origin feature/yeni-ozellik
```

**PR Checklist:**
- ✅ `terraform fmt` çalıştırıldı
- ✅ `terraform validate` başarılı
- ✅ Dokümantasyon güncellendi
- ✅ Anlamlı commit mesajları

### 📝 Kod Standartları

```hcl
# ✅ İyi
resource "github_repository" "example" {
  name        = var.repo_name
  description = "Example repository"
  visibility  = "public"
}

# ❌ Kötü
resource "github_repository" "example" {
name=var.repo_name
description="Example"
}
```

### 🎯 İyi PR Özellikleri

| ✅ Yapılması Gerekenler | ❌ Yapılmaması Gerekenler |
|-------------------------|---------------------------|
| Tek konuya odaklanır | Birçok farklı değişiklik |
| Küçük ve anlaşılır | Çok büyük |
| İyi dokümante edilmiş | Dokümantasyon eksik |
| Test edilmiş | Test edilmemiş |

### 🆘 Yardım
- 📧 [Issue açın](https://github.com/BKT-DevOps/01-github-infra/issues)
- 💬 [Discussions](https://github.com/BKT-DevOps/01-github-infra/discussions)
- 📖 [Documentation](https://github.com/BKT-DevOps/01-github-infra#readme)

### 📜 Lisans
Katkılarınız `LICENSE` dosyasında belirtilen lisans altındadır.

**Teşekkürler! Her katkı topluluğumuzu güçlendirir.** 💪
</details>
---

<details open>
<summary><strong>🇬🇧 English</strong></summary>
### Contributing

Thank you for considering contributing to BKT-DevOps community! 🎉

### 🚀 Quick Start

#### Requirements
- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [GitHub Personal Access Token](https://github.com/settings/tokens)
- Git

#### Setup
```bash
# Fork and clone the repository
git clone https://github.com/YOUR-USERNAME/01-github-infra.git
cd 01-github-infra

# Initialize Terraform
terraform init

# Set your token
export TF_VAR_github_token="ghp_your_token"
```

### 📋 Contribution Process

#### 1. Create an Issue
Open an issue for new features or bug reports.

#### 2. Create a Branch
```bash
git checkout -b feature/new-feature
# or
git checkout -b bugfix/bug-fix
```

**Branch Naming:**
- `feature/` - New features
- `bugfix/` - Bug fixes
- `docs/` - Documentation
- `refactor/` - Code improvements

#### 3. Make Changes
```bash
# Write and format your code
terraform fmt
terraform validate
terraform plan
```

#### 4. Commit
```bash
# Meaningful commit messages
git commit -m "feat: add wiki page creation"
git commit -m "fix: correct team permission"
git commit -m "docs: update README"
```

**Commit Prefixes:**
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation
- `refactor:` - Code improvement
- `chore:` - Other

#### 5. Submit Pull Request
```bash
git push origin feature/new-feature
```

**PR Checklist:**
- ✅ `terraform fmt` executed
- ✅ `terraform validate` successful
- ✅ Documentation updated
- ✅ Meaningful commit messages

### 📝 Code Standards

```hcl
# ✅ Good
resource "github_repository" "example" {
  name        = var.repo_name
  description = "Example repository"
  visibility  = "public"
}

# ❌ Bad
resource "github_repository" "example" {
name=var.repo_name
description="Example"
}
```

### 🎯 Good PR Characteristics

| ✅ Do | ❌ Don't |
|-------|----------|
| Focused on single topic | Multiple different changes |
| Small and clear | Too large |
| Well documented | Missing documentation |
| Tested | Untested |

### 🆘 Help
- 📧 [Open an issue](https://github.com/BKT-DevOps/01-github-infra/issues)
- 💬 [Discussions](https://github.com/BKT-DevOps/01-github-infra/discussions)
- 📖 [Documentation](https://github.com/BKT-DevOps/01-github-infra#readme)

### 📜 License
Your contributions are under the license specified in `LICENSE`.

**Thank you! Every contribution strengthens our community.** 💪
</details>
---

**Son güncelleme | Last updated:** 20 Mayıs 2025 | May 20, 2025
```