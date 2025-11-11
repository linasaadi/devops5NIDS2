# devops

Run locally with Maven
- Build and test:
  - `mvn -B -ntp test`
  - `mvn -B -ntp package`
- Configure DB via env vars (recommended):
  - `SPRING_DATASOURCE_URL` (e.g., `jdbc:mysql://localhost:3306/timesheet`)
  - `SPRING_DATASOURCE_USERNAME` (e.g., `app`)
  - `SPRING_DATASOURCE_PASSWORD`
- Start:
  - `java -jar target/*.jar`

Run with Docker (recommended)
- Build and run app + MySQL:
  - `docker compose up --build`

Security-minded defaults
- Non-root user in Docker image
- Spring Boot safer defaults: no error details, HttpOnly cookies, health/info endpoints only
- DB credentials via env vars; schema changes disabled by default (`ddl-auto=none`)

## CI/CD via Self-Hosted GitHub Actions Runner

- Runner labels: `self-hosted, linux, x64, ci`
- Prereqs (host): Docker installed, access to `/var/run/docker.sock`, outbound HTTPS to GitHub and your n8n instance.
- GitHub Secrets (repo settings → Secrets and variables → Actions):
  - `N8N_WEBHOOK` (required)
  - `REGISTRY_SERVER`, `REGISTRY_USERNAME`, `REGISTRY_PASSWORD` (optional for pushes)
  - `DAST_TARGET_URL` (optional for ZAP)
- Start the runner:
  - Create and fill `runner.env` (see template in repo).
  - `docker compose up -d`
- Workflow triggers:
  - Push to `main`, any PR, or manual `Run workflow` (optional `zap_target`).
- Security results (SARIF):
  - CodeQL, Trivy (fs/image), and Gitleaks results appear under GitHub Security → Code scanning alerts.
- Deployment:
  - Safe no-op by default. Un-comment systemd/JAR or Docker run example in `.github/workflows/ci.yml`.
