# GitHub CI/CD Workflow

## Goal
- Commit each completed change quickly.
- Use GitHub push/PR as the trigger for CI/CD.
- Demonstrate a separated frontend + backend delivery flow.

## 1) Initialize local workflow
```bash
chmod +x scripts/setup-git-workflow.sh
./scripts/setup-git-workflow.sh
```

This configures:
- `core.hooksPath=.githooks`
- `pre-push` hook:
  - blocks push if working tree is dirty
  - runs backend tests before push
  - runs frontend build before push (if frontend exists)

## 2) Commit strategy
- Manual checkpoint commit:
```bash
scripts/checkpoint.sh "feat: your message"
```

- Optional auto-commit watcher (commit every few seconds if there are edits):
```bash
scripts/autocommit.sh
```

Env options:
- `AUTOCOMMIT_INTERVAL` (default: `3`)
- `AUTOCOMMIT_PREFIX` (default: `chore(auto): savepoint`)

Example:
```bash
AUTOCOMMIT_INTERVAL=2 AUTOCOMMIT_PREFIX="chore(auto): save" scripts/autocommit.sh
```

## 3) GitHub as CI/CD medium
- CI/CD workflow file: `.github/workflows/ci-cd.yml`
- Trigger:
  - push to `main/master`
  - pull request to `main/master`
  - push tag like `v1.0.0`
- Actions:
  - backend CI (`./mvnw -B clean verify`)
  - frontend CI (`npm install` + `npm run build`)
  - build two Docker images (`backend`, `frontend`)
  - push images to GHCR only on `main/master` or version tags

Image names:
- `ghcr.io/<owner>/<repo>-backend`
- `ghcr.io/<owner>/<repo>-frontend`

## 4) Local demo run
```bash
docker compose -f compose/docker-compose.demo.yml up --build
```

Open:
- `http://127.0.0.1:8080`

The frontend page calls backend API through `/api/message`.

## 5) Recommended daily flow
```bash
git checkout -b feat/xxx
# code changes...
scripts/checkpoint.sh "feat: implement xxx"
git push -u origin feat/xxx
# open PR on GitHub
```
