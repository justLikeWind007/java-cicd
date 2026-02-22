# 企业级 CI/CD 落地说明

## 1. 工作流清单

- `.github/workflows/ci.yml`
  - 后端质量门禁（Maven verify）
  - 前端质量门禁（npm ci + build）
  - 依赖安全审查（PR）
- `.github/workflows/cd.yml`
  - 发布前门禁（后端测试 + 前端构建）
  - 后端镜像构建与发布（GHCR）
  - 前端镜像构建与发布（GHCR）
  - SBOM 与 Provenance 产出
  - Trivy 配置扫描并上报 SARIF
- `.github/workflows/deploy.yml`
  - 手工触发部署（dev/staging/prod）
  - 使用 SSH 登录目标服务器并拉取镜像更新
- `.github/workflows/codeql.yml`
  - Java 与 JavaScript CodeQL 扫描（push/PR/定时）

## 2. 必备仓库设置

### 2.1 Actions 权限

在 `Settings -> Actions -> General` 中设置：

- Workflow permissions: `Read and write permissions`
- 勾选允许 Actions 创建 PR（建议）

### 2.2 Environments

在 `Settings -> Environments` 创建：

- `dev`
- `staging`
- `prod`

建议：

- `prod` 开启 required reviewers（发布审批）

### 2.3 Branch Protection

在默认分支（`main` 或 `master`）开启：

- Require a pull request before merging
- Require status checks to pass before merging
- Require branches to be up to date before merging

建议将以下检查设为必需：

- `后端质量门禁`
- `前端质量门禁`
- `依赖安全审查`
- `CodeQL 扫描`

## 3. 必备 Secrets

仓库级（或环境级）Secrets：

- `GHCR_USERNAME`：可读取 GHCR 的账号
- `GHCR_PAT`：GHCR 访问令牌（`read:packages`，如需写入则附加 `write:packages`）
- `DEPLOY_HOST`：目标服务器地址
- `DEPLOY_USER`：目标服务器账号
- `DEPLOY_SSH_KEY`：目标服务器私钥（PEM）

## 4. 日常发布流程

1. 开发分支提交代码并发起 PR
2. CI 通过后合并到主分支
3. CD 自动发布镜像到 GHCR
4. 手工触发 `企业级部署` 工作流，填写：
   - `environment`
   - `backend_image_tag`
   - `frontend_image_tag`

## 5. 标准回滚流程

1. 在 GHCR 找到上一稳定镜像 tag
2. 重新执行 `企业级部署`，将 tag 改为上一版本
3. 验证健康检查与关键接口

## 6. 建议的命名规范

- 版本标签：`vX.Y.Z`（例如 `v1.2.0`）
- 发布分支：`release/vX.Y.Z`
- 紧急修复：`hotfix/xxx`
