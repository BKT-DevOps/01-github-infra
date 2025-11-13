# 📁 Generic Project Structure | Genel Proje Yapısı

<details open>
<summary><strong>🇹🇷 Türkçe</strong></summary>

<br>

Bu doküman tüm proje tipleri için (React, Angular, Node.js, Python, Go, vb.) geçerli **evrensel** klasör yapısını ve dosya organizasyonunu açıklar.

## 🏗️ Temel Proje Yapısı

```
project-name/
├── 📁 .github/                    # GitHub özel dosyaları
│   ├── workflows/                 # CI/CD pipeline dosyaları
│   │   ├── ci.yml                # Continuous Integration
│   │   ├── cd.yml                # Continuous Deployment
│   │   ├── pr-checks.yml         # Pull Request kontrolleri
│   │   └── release.yml           # Release otomasyonu
│   ├── ISSUE_TEMPLATE/           # Issue şablonları
│   │   ├── bug_report.md
│   │   ├── feature_request.md
│   │   └── custom.md
│   ├── PULL_REQUEST_TEMPLATE.md  # PR şablonu
│   ├── CODEOWNERS                # Code review sahipleri
│   └── dependabot.yml            # Otomatik dependency güncellemeleri
│
├── 📁 docs/                       # Dokümantasyon
│   ├── api/                      # API dokümantasyonu
│   │   ├── endpoints.md
│   │   └── authentication.md
│   ├── guides/                   # Kullanıcı rehberleri
│   │   ├── getting-started.md
│   │   ├── installation.md
│   │   └── deployment.md
│   ├── architecture/             # Mimari dokümantasyon
│   │   ├── overview.md
│   │   ├── design-decisions.md
│   │   └── diagrams/
│   ├── development/              # Geliştirme dokümantasyonu
│   │   ├── setup.md
│   │   ├── workflow.md
│   │   └── coding-standards.md
│   └── examples/                 # Kod örnekleri
│
├── 📁 src/                        # Ana kaynak kod (dile göre değişir)
│   └── ...                       # Proje tipine göre organize edilir
│
├── 📁 tests/                      # Test dosyaları
│   ├── unit/                     # Birim testler
│   ├── integration/              # Entegrasyon testleri
│   ├── e2e/                      # End-to-end testler
│   ├── __mocks__/                # Test mock'ları
│   └── fixtures/                 # Test verileri
│
├── 📁 config/                     # Konfigürasyon dosyaları
│   ├── environments/             # Environment bazlı config
│   │   ├── dev.yaml
│   │   ├── staging.yaml
│   │   └── prod.yaml
│   └── ...                       # Diğer config dosyaları
│
├── 📁 scripts/                    # Yardımcı scriptler
│   ├── setup.sh                  # İlk kurulum scripti
│   ├── dev.sh                    # Development başlatma
│   ├── build.sh                  # Build scripti
│   ├── test.sh                   # Test runner
│   ├── deploy.sh                 # Deployment scripti
│   └── cleanup.sh                # Temizlik scripti
│
├── 📁 assets/                     # Statik dosyalar (opsiyonel)
│   ├── images/
│   ├── fonts/
│   └── icons/
│
├── 📁 .vscode/                    # VS Code ayarları (opsiyonel)
│   ├── settings.json
│   ├── extensions.json
│   └── launch.json
│
├── 📄 README.md                   # Proje ana bilgileri
├── 📄 CHANGELOG.md                # Değişiklik geçmişi (Keep a Changelog)
├── 📄 CONTRIBUTING.md             # Katkı rehberi
├── 📄 LICENSE                     # Lisans dosyası
├── 📄 SECURITY.md                 # Güvenlik politikası
├── 📄 CODE_OF_CONDUCT.md          # Davranış kuralları
├── 📄 .gitignore                  # Git ignore kuralları
├── 📄 .gitattributes              # Git attributes
├── 📄 .editorconfig               # Editor konfigürasyonu
├── 📄 .env.example                # Environment variables örneği
├── 📄 .dockerignore               # Docker ignore
├── 📄 Dockerfile                  # Docker image tanımı
└── 📄 docker-compose.yml          # Docker compose setup
```

## 🎯 Dile/Framework'e Göre Ek Dosyalar

### 🟨 Node.js / JavaScript / TypeScript
```
Ek Dosyalar:
├── package.json                   # Bağımlılıklar ve scriptler
├── package-lock.json              # Lock file
├── tsconfig.json                  # TypeScript config
├── .eslintrc.js                   # ESLint kuralları
├── .eslintignore                  # ESLint ignore
├── .prettierrc                    # Prettier config
├── .prettierignore                # Prettier ignore
├── jest.config.js                 # Jest test config
├── .npmrc                         # NPM config
└── .nvmrc                         # Node version

src/ Yapısı:
├── components/                    # Bileşenler
├── pages/ veya screens/           # Sayfalar/Ekranlar
├── hooks/                         # Custom hooks
├── utils/                         # Yardımcı fonksiyonlar
├── services/                      # API servisleri
├── types/                         # TypeScript type tanımları
├── constants/                     # Sabitler
├── styles/                        # Stil dosyaları
├── assets/                        # Görseller, fontlar
└── index.ts                       # Entry point
```

### 🐍 Python
```
Ek Dosyalar:
├── requirements.txt               # Bağımlılıklar
├── requirements-dev.txt           # Development bağımlılıkları
├── setup.py                       # Paket setup
├── pyproject.toml                 # Modern Python config
├── .pylintrc                      # Pylint config
├── .flake8                        # Flake8 config
├── pytest.ini                     # Pytest config
├── .python-version                # Python version (pyenv)
└── Pipfile                        # Pipenv (alternatif)

src/ veya Proje Adı/ Yapısı:
├── __init__.py
├── main.py                        # Entry point
├── models/                        # Veri modelleri
├── services/                      # İş mantığı
├── utils/                         # Yardımcı fonksiyonlar
├── api/                           # API endpoints
│   ├── __init__.py
│   ├── routes.py
│   └── controllers.py
└── config/                        # Konfigürasyon
```

### 🔵 Go
```
Ek Dosyalar:
├── go.mod                         # Go module tanımı
├── go.sum                         # Dependency checksums
├── Makefile                       # Build automation
└── .golangci.yml                  # Linter config

Proje Yapısı (Standard Go Layout):
├── cmd/                           # Main applications
│   └── app/
│       └── main.go
├── internal/                      # Private application code
│   ├── handlers/
│   ├── models/
│   └── services/
├── pkg/                           # Public libraries
├── api/                           # API specifications
├── web/                           # Web assets
└── build/                         # Build artifacts
```

### ☕ Java / Spring Boot
```
Ek Dosyalar:
├── pom.xml                        # Maven
└── build.gradle                   # Gradle (alternatif)

src/ Yapısı:
├── main/
│   ├── java/
│   │   └── com/company/project/
│   │       ├── controller/
│   │       ├── service/
│   │       ├── repository/
│   │       ├── model/
│   │       ├── config/
│   │       └── Application.java
│   └── resources/
│       ├── application.properties
│       └── static/
└── test/
    └── java/
```

### ⚛️ React / React Native
```
Ek Dosyalar:
├── package.json
├── tsconfig.json
├── .eslintrc.js
├── .prettierrc
├── babel.config.js                # React Native için
└── metro.config.js                # React Native için

src/ Yapısı:
├── components/                    # Reusable components
│   ├── common/                   # Shared components
│   └── features/                 # Feature-specific
├── screens/ veya pages/          # Screen/Page components
├── navigation/                    # Navigation (RN için)
├── hooks/                        # Custom hooks
├── context/                      # React Context
├── services/                     # API services
├── utils/                        # Helper functions
├── types/                        # TypeScript types
├── constants/                    # Constants
├── assets/                       # Images, fonts
├── styles/                       # Global styles
└── App.tsx                       # Root component
```

### 🅰️ Angular
```
Ek Dosyalar:
├── package.json
├── angular.json                   # Angular CLI config
├── tsconfig.json
├── tsconfig.app.json
├── tsconfig.spec.json
└── karma.conf.js                  # Test config

src/ Yapısı:
├── app/
│   ├── core/                     # Singleton services
│   ├── shared/                   # Shared modules
│   ├── features/                 # Feature modules
│   │   └── feature-name/
│   │       ├── components/
│   │       ├── services/
│   │       ├── models/
│   │       └── feature.module.ts
│   ├── app.component.ts
│   └── app.module.ts
├── assets/
├── environments/
└── index.html
```

### 🔌 REST API (Express/Fastify)
```
src/ Yapısı:
├── controllers/                   # Route controllers
├── routes/                        # API routes
├── models/                        # Data models
├── services/                      # Business logic
├── middleware/                    # Express middleware
├── utils/                         # Helper functions
├── validators/                    # Input validation
├── types/                         # TypeScript types
├── config/                        # Configuration
├── db/                           # Database
│   ├── migrations/
│   └── seeds/
└── server.ts                      # Entry point
```

## 📋 Zorunlu Dosyalar ve İçerikleri

### 1. README.md
```markdown
# Project Name

Brief description

## 🚀 Quick Start
## 📦 Installation
## 🔧 Configuration
## 📖 Documentation
## 🧪 Testing
## 🤝 Contributing
## 📄 License
```

### 2. .gitignore
Her dil için spesifik ignore kuralları (gitignore.io kullan)

### 3. .editorconfig
```ini
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

[*.md]
trim_trailing_whitespace = false

[*.py]
indent_size = 4
```

### 4. .env.example
```bash
# Database
DATABASE_URL=postgresql://user:pass@localhost:5432/db

# API
API_KEY=your_api_key_here
API_URL=https://api.example.com

# Environment
NODE_ENV=development
PORT=3000
```

### 5. CONTRIBUTING.md
Katkı kuralları, branch stratejisi, commit message formatı

### 6. SECURITY.md
Güvenlik açığı bildirimi için talimatlar

### 7. CODE_OF_CONDUCT.md
Davranış kuralları (Contributor Covenant kullanılabilir)

### 8. CHANGELOG.md
```markdown
# Changelog

## [Unreleased]

## [1.0.0] - 2024-01-01
### Added
- Initial release
```

## 🔧 CI/CD Pipeline Örnekleri

### .github/workflows/ci.yml
```yaml
name: CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run tests
        run: npm test
      - name: Run linter
        run: npm run lint
```

## 📝 Dosya Adlandırma Kuralları

### ✅ İyi Örnekler:
- `userController.ts`
- `auth.service.ts`
- `Button.component.tsx`
- `user.types.ts`
- `api.utils.ts`
- `db.config.ts`

### ❌ Kötü Örnekler:
- `file1.js`
- `temp.tsx`
- `test.ts`
- `utils.js` (çok genel)
- `newfile.ts`

## 🎨 Stil ve Format Standartları

### Genel Kurallar:
- **camelCase**: Değişkenler, fonksiyonlar
- **PascalCase**: Class'lar, Component'ler
- **kebab-case**: Dosya adları (opsiyonel)
- **SCREAMING_SNAKE_CASE**: Sabitler

### Commit Message:
```
type(scope): subject

body

footer
```

Tipler: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

</details>

---

<details>
<summary><strong>🇬🇧 English</strong></summary>

<br>

This document explains the **universal** folder structure and file organization for all project types (React, Angular, Node.js, Python, Go, etc.).

## 🏗️ Base Project Structure

```
project-name/
├── 📁 .github/                    # GitHub specific files
│   ├── workflows/                 # CI/CD pipeline files
│   │   ├── ci.yml                # Continuous Integration
│   │   ├── cd.yml                # Continuous Deployment
│   │   ├── pr-checks.yml         # Pull Request checks
│   │   └── release.yml           # Release automation
│   ├── ISSUE_TEMPLATE/           # Issue templates
│   │   ├── bug_report.md
│   │   ├── feature_request.md
│   │   └── custom.md
│   ├── PULL_REQUEST_TEMPLATE.md  # PR template
│   ├── CODEOWNERS                # Code review owners
│   └── dependabot.yml            # Automatic dependency updates
│
├── 📁 docs/                       # Documentation
│   ├── api/                      # API documentation
│   │   ├── endpoints.md
│   │   └── authentication.md
│   ├── guides/                   # User guides
│   │   ├── getting-started.md
│   │   ├── installation.md
│   │   └── deployment.md
│   ├── architecture/             # Architecture documentation
│   │   ├── overview.md
│   │   ├── design-decisions.md
│   │   └── diagrams/
│   ├── development/              # Development documentation
│   │   ├── setup.md
│   │   ├── workflow.md
│   │   └── coding-standards.md
│   └── examples/                 # Code examples
│
├── 📁 src/                        # Main source code (varies by language)
│   └── ...                       # Organized by project type
│
├── 📁 tests/                      # Test files
│   ├── unit/                     # Unit tests
│   ├── integration/              # Integration tests
│   ├── e2e/                      # End-to-end tests
│   ├── __mocks__/                # Test mocks
│   └── fixtures/                 # Test data
│
├── 📁 config/                     # Configuration files
│   ├── environments/             # Environment-based config
│   │   ├── dev.yaml
│   │   ├── staging.yaml
│   │   └── prod.yaml
│   └── ...                       # Other config files
│
├── 📁 scripts/                    # Helper scripts
│   ├── setup.sh                  # Initial setup script
│   ├── dev.sh                    # Development startup
│   ├── build.sh                  # Build script
│   ├── test.sh                   # Test runner
│   ├── deploy.sh                 # Deployment script
│   └── cleanup.sh                # Cleanup script
│
├── 📁 assets/                     # Static assets (optional)
│   ├── images/
│   ├── fonts/
│   └── icons/
│
├── 📁 .vscode/                    # VS Code settings (optional)
│   ├── settings.json
│   ├── extensions.json
│   └── launch.json
│
├── 📄 README.md                   # Project main information
├── 📄 CHANGELOG.md                # Change history (Keep a Changelog)
├── 📄 CONTRIBUTING.md             # Contribution guide
├── 📄 LICENSE                     # License file
├── 📄 SECURITY.md                 # Security policy
├── 📄 CODE_OF_CONDUCT.md          # Code of conduct
├── 📄 .gitignore                  # Git ignore rules
├── 📄 .gitattributes              # Git attributes
├── 📄 .editorconfig               # Editor configuration
├── 📄 .env.example                # Environment variables example
├── 📄 .dockerignore               # Docker ignore
├── 📄 Dockerfile                  # Docker image definition
└── 📄 docker-compose.yml          # Docker compose setup
```

## 🎯 Language/Framework Specific Files

### 🟨 Node.js / JavaScript / TypeScript
```
Additional Files:
├── package.json                   # Dependencies and scripts
├── package-lock.json              # Lock file
├── tsconfig.json                  # TypeScript config
├── .eslintrc.js                   # ESLint rules
├── .eslintignore                  # ESLint ignore
├── .prettierrc                    # Prettier config
├── .prettierignore                # Prettier ignore
├── jest.config.js                 # Jest test config
├── .npmrc                         # NPM config
└── .nvmrc                         # Node version

src/ Structure:
├── components/                    # Components
├── pages/ or screens/             # Pages/Screens
├── hooks/                         # Custom hooks
├── utils/                         # Helper functions
├── services/                      # API services
├── types/                         # TypeScript type definitions
├── constants/                     # Constants
├── styles/                        # Style files
├── assets/                        # Images, fonts
└── index.ts                       # Entry point
```

### 🐍 Python
```
Additional Files:
├── requirements.txt               # Dependencies
├── requirements-dev.txt           # Development dependencies
├── setup.py                       # Package setup
├── pyproject.toml                 # Modern Python config
├── .pylintrc                      # Pylint config
├── .flake8                        # Flake8 config
├── pytest.ini                     # Pytest config
├── .python-version                # Python version (pyenv)
└── Pipfile                        # Pipenv (alternative)

src/ or Project Name/ Structure:
├── __init__.py
├── main.py                        # Entry point
├── models/                        # Data models
├── services/                      # Business logic
├── utils/                         # Helper functions
├── api/                           # API endpoints
│   ├── __init__.py
│   ├── routes.py
│   └── controllers.py
└── config/                        # Configuration
```

### 🔵 Go
```
Additional Files:
├── go.mod                         # Go module definition
├── go.sum                         # Dependency checksums
├── Makefile                       # Build automation
└── .golangci.yml                  # Linter config

Project Structure (Standard Go Layout):
├── cmd/                           # Main applications
│   └── app/
│       └── main.go
├── internal/                      # Private application code
│   ├── handlers/
│   ├── models/
│   └── services/
├── pkg/                           # Public libraries
├── api/                           # API specifications
├── web/                           # Web assets
└── build/                         # Build artifacts
```

### ☕ Java / Spring Boot
```
Additional Files:
├── pom.xml                        # Maven
└── build.gradle                   # Gradle (alternative)

src/ Structure:
├── main/
│   ├── java/
│   │   └── com/company/project/
│   │       ├── controller/
│   │       ├── service/
│   │       ├── repository/
│   │       ├── model/
│   │       ├── config/
│   │       └── Application.java
│   └── resources/
│       ├── application.properties
│       └── static/
└── test/
    └── java/
```

### ⚛️ React / React Native
```
Additional Files:
├── package.json
├── tsconfig.json
├── .eslintrc.js
├── .prettierrc
├── babel.config.js                # For React Native
└── metro.config.js                # For React Native

src/ Structure:
├── components/                    # Reusable components
│   ├── common/                   # Shared components
│   └── features/                 # Feature-specific
├── screens/ or pages/            # Screen/Page components
├── navigation/                    # Navigation (for RN)
├── hooks/                        # Custom hooks
├── context/                      # React Context
├── services/                     # API services
├── utils/                        # Helper functions
├── types/                        # TypeScript types
├── constants/                    # Constants
├── assets/                       # Images, fonts
├── styles/                       # Global styles
└── App.tsx                       # Root component
```

### 🅰️ Angular
```
Additional Files:
├── package.json
├── angular.json                   # Angular CLI config
├── tsconfig.json
├── tsconfig.app.json
├── tsconfig.spec.json
└── karma.conf.js                  # Test config

src/ Structure:
├── app/
│   ├── core/                     # Singleton services
│   ├── shared/                   # Shared modules
│   ├── features/                 # Feature modules
│   │   └── feature-name/
│   │       ├── components/
│   │       ├── services/
│   │       ├── models/
│   │       └── feature.module.ts
│   ├── app.component.ts
│   └── app.module.ts
├── assets/
├── environments/
└── index.html
```

### 🔌 REST API (Express/Fastify)
```
src/ Structure:
├── controllers/                   # Route controllers
├── routes/                        # API routes
├── models/                        # Data models
├── services/                      # Business logic
├── middleware/                    # Express middleware
├── utils/                         # Helper functions
├── validators/                    # Input validation
├── types/                         # TypeScript types
├── config/                        # Configuration
├── db/                           # Database
│   ├── migrations/
│   └── seeds/
└── server.ts                      # Entry point
```

## 📋 Required Files and Contents

### 1. README.md
```markdown
# Project Name

Brief description

## 🚀 Quick Start
## 📦 Installation
## 🔧 Configuration
## 📖 Documentation
## 🧪 Testing
## 🤝 Contributing
## 📄 License
```

### 2. .gitignore
Language-specific ignore rules (use gitignore.io)

### 3. .editorconfig
```ini
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

[*.md]
trim_trailing_whitespace = false

[*.py]
indent_size = 4
```

### 4. .env.example
```bash
# Database
DATABASE_URL=postgresql://user:pass@localhost:5432/db

# API
API_KEY=your_api_key_here
API_URL=https://api.example.com

# Environment
NODE_ENV=development
PORT=3000
```

### 5. CONTRIBUTING.md
Contribution rules, branch strategy, commit message format

### 6. SECURITY.md
Instructions for reporting security vulnerabilities

### 7. CODE_OF_CONDUCT.md
Code of conduct (Contributor Covenant can be used)

### 8. CHANGELOG.md
```markdown
# Changelog

## [Unreleased]

## [1.0.0] - 2024-01-01
### Added
- Initial release
```

## 🔧 CI/CD Pipeline Examples

### .github/workflows/ci.yml
```yaml
name: CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run tests
        run: npm test
      - name: Run linter
        run: npm run lint
```

## 📝 File Naming Conventions

### ✅ Good Examples:
- `userController.ts`
- `auth.service.ts`
- `Button.component.tsx`
- `user.types.ts`
- `api.utils.ts`
- `db.config.ts`

### ❌ Bad Examples:
- `file1.js`
- `temp.tsx`
- `test.ts`
- `utils.js` (too generic)
- `newfile.ts`

## 🎨 Style and Format Standards

### General Rules:
- **camelCase**: Variables, functions
- **PascalCase**: Classes, Components
- **kebab-case**: File names (optional)
- **SCREAMING_SNAKE_CASE**: Constants

### Commit Message:
```
type(scope): subject

body

footer
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

</details>

---

## 📚 Useful Resources | Faydalı Kaynaklar

- [Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)
- [React Folder Structure](https://www.robinwieruch.de/react-folder-structure/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Standard Go Project Layout](https://github.com/golang-standards/project-layout)
- [Python Project Structure](https://docs.python-guide.org/writing/structure/)
- [Keep a Changelog](https://keepachangelog.com/)
- [Semantic Versioning](https://semver.org/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitIgnore.io](https://www.toptal.com/developers/gitignore)
- [Contributor Covenant](https://www.contributor-covenant.org/)

---

## 🎯 Quick Start Checklist | Hızlı Başlangıç Kontrol Listesi

### Initial Setup | İlk Kurulum
- [ ] Create repository | Repo oluştur
- [ ] Add README.md
- [ ] Add LICENSE
- [ ] Add .gitignore
- [ ] Add .editorconfig
- [ ] Add CONTRIBUTING.md
- [ ] Add SECURITY.md
- [ ] Add CODE_OF_CONDUCT.md
- [ ] Add CHANGELOG.md
- [ ] Create basic folder structure | Temel klasör yapısını oluştur
- [ ] Setup CI/CD pipelines | CI/CD pipeline'ları kur
- [ ] Add issue templates | Issue şablonları ekle
- [ ] Add PR template | PR şablonu ekle
- [ ] Configure branch protection | Branch koruma ayarla
- [ ] Add CODEOWNERS file | CODEOWNERS dosyası ekle

### Language Specific | Dile Özel
- [ ] Add language config files | Dil config dosyaları ekle
- [ ] Setup linting | Linting kur
- [ ] Setup formatting | Formatting kur
- [ ] Setup testing | Testing kur
- [ ] Add pre-commit hooks | Pre-commit hook'ları ekle

---

*This document provides a universal project structure that can be adapted for any programming language or framework. | Bu doküman, herhangi bir programlama dili veya framework için uyarlanabilecek evrensel bir proje yapısı sağlar.*