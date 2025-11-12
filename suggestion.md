# Öneri

## Genel Yapı
Her dizin başka bir servisin / projenin IaC tanımını içeriyor:
```
projects/
	project-crm/
		main.tf
		variables.tf
	project-api/
		main.tf
		variables.tf
	project-frontend/
		main.tf
		variables.tf
.github/workflows/daily-terraform-apply.yml
```
Pipeline her gece 12’de tüm bu klasörleri sırayla apply ediyor.
  
  ## Terraform tarafı
  
Her proje dizini bağımsız bir Terraform workspace gibi davranmalı.

```
terraform {
	backend "s3" {
	bucket = "bkt-terraform-states"
	key = "project-api/terraform.tfstate"
	region = "eu-central-1"
	dynamodb_table = "terraform-locks"
	}
}
```

Yani her klasörün kendi remote state’i olacak.

Bu sayede:

- Her projenin state’i izole olur.
- Birinin apply’ı diğerini bozmaz.
- Paralel değişiklikler çakışmaz.

## Pipeline Mantığı

-   Repo’yu çeker,
    
-   `projects` dizinindeki her klasörü listeler,
    
-   Her birine sırayla girip:
    
    -   `terraform init`
        
    -   `terraform apply -auto-approve`  
        komutlarını çalıştırır.

Böylece yeni bir proje eklendiğinde **hiçbir ek YAML yazmadan** otomatik devreye alınır

### Örnek:
```
name: Nightly Terraform Apply

on:
  schedule:
    - cron: '0 0 * * *'  # Her gece 00:00 UTC
  workflow_dispatch:      # Manuel tetikleme opsiyonu

jobs:
  apply-all:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repo
        uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.9.5

      - name: Loop through project directories and apply
        env:
          GITHUB_TOKEN: ${{ secrets.GH_PAT }}
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        run: |
          cd projects
          for dir in */; do
            echo "=== Applying Terraform in $dir ==="
            cd "$dir"

            terraform init -input=false
            terraform apply -auto-approve

            cd ..
          done

```

### 🔸 Ne yapıyor?

-   `for dir in */` ifadesiyle `projects/` altındaki her klasöre giriyor.
    
-   Her birinde `init` ve `apply` yapıyor.
    
-   Her proje kendi backend’ini okuyor → kendi state dosyasını buluyor.
    
-   Sonra apply edip çıkıyor.

### 🔸 Sonuç:

Gece 12’de pipeline çalıştığında:

-   Tüm projelerin Terraform kodu apply ediliyor.
    
-   Her biri kendi state’ini güncelliyor.
    
-   Kodun dışında yapılan değişiklikler (örneğin biri elle GitHub’ta repo açtıysa) silinip sistem eski haline dönüyor 