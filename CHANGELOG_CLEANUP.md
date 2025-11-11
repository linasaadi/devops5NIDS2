# Repository Cleanup Summary

Consolidated CI/CD and security scanning into a single GitHub Actions workflow and replaced the compose stack with a self-hosted runner.

## Replaced

- `docker-compose.yml`
  - Old: app + MySQL stack for local dev
  - New: single self-hosted GitHub Actions runner (labels: self-hosted, linux, x64, ci)

## Deleted (consolidated into `.github/workflows/ci.yml`)

- `.github/workflows/codeql.yml`
- `.github/workflows/dependency-review.yml`
- `.github/workflows/deploy.yml`
- `.github/workflows/gitleaks.yml`
- `.github/workflows/trivy-scan.yml`
- `.github/workflows/zap-baseline.yml`

## Kept

- `.gitleaks.toml` (used by secrets job if present)
- `Dockerfile` (used if building container)
- Maven wrapper + `pom.xml` + `src/` (used by build-test job)

## Notes

- Jenkins pipeline replaced fully by GitHub Actions (CodeQL + Trivy supplant prior Sonar/SCA steps).
- n8n integration now uses a single `N8N_WEBHOOK` secret with consistent payloads.

