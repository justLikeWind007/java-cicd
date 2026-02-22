# GitHub CI/CD Workflow

## Goal
- Commit each completed change quickly.
- Use GitHub push/PR as the trigger for CI/CD.

## 1) Initialize local workflow
```bash
chmod +x scripts/setup-git-workflow.sh
./scripts/setup-git-workflow.sh
```

This configures:
- `core.hooksPath=.githooks`
- `pre-push` hook:
  - blocks push if working tree is dirty
  - runs `./mvnw -q test` before push

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
- Actions:
  - build & test with Maven
  - build Docker image
  - push image to GHCR on `push`

## 4) Recommended daily flow
```bash
git checkout -b feat/xxx
# code changes...
scripts/checkpoint.sh "feat: implement xxx"
git push -u origin feat/xxx
# open PR on GitHub
```
