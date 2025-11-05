# 🔐 Verified Commits Guide | Doğrulanmış Commit Rehberi

<details open>
<summary><strong>🇹🇷 Türkçe</strong></summary>

<br>

## Verified Commit Nedir?

Verified commit, GitHub'da commit'lerin gerçekten belirtilen kullanıcı tarafından yapıldığını doğrulayan bir güvenlik özelliğidir. GPG anahtarı ile imzalanmış commit'ler GitHub'da yeşil "Verified" rozeti ile görünür.

## Neden Önemli?

- ✅ **Güvenlik**: Commit'lerin gerçek sahibini doğrular
- ✅ **Güven**: Takım içinde güvenilirlik sağlar
- ✅ **Compliance**: Kurumsal güvenlik standartlarını karşılar
- ✅ **Audit**: Değişikliklerin takibini kolaylaştırır

## Kurulum Adımları

### 1. GPG Anahtarı Oluşturma

```bash
# GPG yüklü mü kontrol et
gpg --version

# Yeni GPG anahtarı oluştur
gpg --full-generate-key

# RSA seç ve 4096 bit boyutu kullan
# Email adresini GitHub hesabındaki ile aynı yap
```

### 2. GPG Anahtarını GitHub'a Ekleme

```bash
# GPG anahtarlarını listele
gpg --list-secret-keys --keyid-format=long

# Public key'i export et
gpg --armor --export YOUR_KEY_ID

# Bu çıktıyı GitHub Settings > SSH and GPG keys > New GPG key'e ekle
```

### 3. Git Konfigürasyonu

```bash
# Global olarak GPG signing'i aktif et
git config --global commit.gpgsign true
git config --global user.signingkey YOUR_KEY_ID

# GPG program path'ini belirle (macOS için)
git config --global gpg.program gpg
```

### 4. Test Et

```bash
# Test commit yap
git commit -S -m "Test verified commit"

# Commit'in imzalandığını kontrol et
git log --show-signature -1
```

## Sorun Giderme

### GPG Agent Sorunları

```bash
# GPG agent'ı yeniden başlat
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent

# Test et
echo "test" | gpg --clearsign
```

### macOS Sorunları

```bash
# GPG Suite kullan veya pinentry ayarla
brew install pinentry-mac
echo "pinentry-program /opt/homebrew/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
```

## IDE Entegrasyonu

### VS Code
1. **GitLens** extension yükle
2. Settings'de "git.enableCommitSigning": true

### IntelliJ/PyCharm
1. Settings > Version Control > Git > Sign off commits ✅

</details>

<details>
<summary><strong>🇬🇧 English</strong></summary>

<br>

## What is a Verified Commit?

A verified commit is a security feature on GitHub that proves commits were actually made by the specified user. Commits signed with a GPG key display a green "Verified" badge on GitHub.

## Why is it Important?

- ✅ **Security**: Verifies the true owner of commits
- ✅ **Trust**: Provides reliability within the team
- ✅ **Compliance**: Meets corporate security standards
- ✅ **Audit**: Facilitates tracking of changes

## Setup Steps

### 1. Generate GPG Key

```bash
# Check if GPG is installed
gpg --version

# Generate new GPG key
gpg --full-generate-key

# Select RSA and use 4096 bit size
# Use the same email as your GitHub account
```

### 2. Add GPG Key to GitHub

```bash
# List GPG keys
gpg --list-secret-keys --keyid-format=long

# Export public key
gpg --armor --export YOUR_KEY_ID

# Add this output to GitHub Settings > SSH and GPG keys > New GPG key
```

### 3. Git Configuration

```bash
# Enable GPG signing globally
git config --global commit.gpgsign true
git config --global user.signingkey YOUR_KEY_ID

# Set GPG program path (for macOS)
git config --global gpg.program gpg
```

### 4. Test

```bash
# Make a test commit
git commit -S -m "Test verified commit"

# Check if commit is signed
git log --show-signature -1
```

## Troubleshooting

### GPG Agent Issues

```bash
# Restart GPG agent
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent

# Test
echo "test" | gpg --clearsign
```

### macOS Issues

```bash
# Use GPG Suite or configure pinentry
brew install pinentry-mac
echo "pinentry-program /opt/homebrew/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
```

## IDE Integration

### VS Code
1. Install **GitLens** extension
2. Enable "git.enableCommitSigning": true in settings

### IntelliJ/PyCharm
1. Settings > Version Control > Git > Sign off commits ✅

</details>

---

## 📚 Faydalı Linkler | Useful Links

- [GitHub GPG Documentation](https://docs.github.com/en/authentication/managing-commit-signature-verification)
- [Git GPG Documentation](https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work)
- [GPG Suite for macOS](https://gpgtools.org/)

---

*Bu dokümantasyon {{PROJECT_NAME}} projesi için hazırlanmıştır.*