# Geliştirme Akışı (Development Workflow)

Bu belge, ${project_name} projesindeki geliştirme süreçleri, standartları ve iş akışları için bir rehberdir.

### İş Akışı (Workflow)

1.  **Issues:** Tüm işler (yeni özellikler, hatalar, görevler) GitHub Issues üzerinden takip edilmelidir. Her iş için bir issue oluşturulmalıdır.
2.  **Branches:** Her issue için `main` branch'inden yeni bir özellik (feature) branch'i oluşturulmalıdır. Branch isimlendirme kuralı: `feature/issue-no-kisa-aciklama` (Örn: `feature/123-add-user-login`).
3.  **Pull Requests (PRs):** Tüm kod değişiklikleri PR üzerinden `main` branch'ine birleştirilmelidir. PR açarken ilgili issue'yu referans gösterin (`Closes #123`).
4.  **Kod İnceleme (Code Review):** Her PR, proje lideri veya belirlenmiş en az bir kıdemli geliştirici tarafından onaylanmalıdır.

### Kod Standartları (Coding Standards)

- Her repository'de tanımlanan kodlama standartlarına ve linting kurallarına uyun.
- Anlaşılır ve açıklayıcı commit mesajları yazın.
- Yeni eklenen veya değiştirilen özellikler için testler yazın.
- Yaptığınız değişikliklerle ilgili dokümantasyonu (README, Wiki vb.) güncelleyin.

### Başlangıç (Getting Started)

- **Ön Koşullar:**
  - Git'in lokal makinenizde kurulu olması.
  - Proje repolarına erişim izninizin olması.
- **Kurulum:**
  - İlgili repoyu klonlayın.
  - Reponun `README.md` dosyasındaki kurulum adımlarını takip edin.
  - İlk görevleriniz için size atanan "initial setup issue"yu inceleyin.