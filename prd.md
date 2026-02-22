# Product Requirements Document (PRD)

## 1. Overview
- Product Name: java-cicd
- Objective: Build a Java project with reliable CI/CD pipeline for build, test, and container delivery.

## 2. Goals
- Automate build and test on every push/PR.
- Build Docker image from source.
- Enable publish-ready CI workflow (GitHub Actions + GHCR).

## 3. Scope
### In Scope
- Maven-based Java service.
- Unit-test execution in CI.
- Docker image build and optional push on push events.

### Out of Scope
- Production deployment orchestration (Kubernetes/Helm) in this phase.
- Full observability stack setup.

## 4. Functional Requirements
- FR1: CI must run `mvn clean verify` on push and pull request.
- FR2: CI must build Docker image from repository Dockerfile.
- FR3: CI should push image to registry on push events.

## 5. Non-Functional Requirements
- NFR1: Build reproducibility using Maven Wrapper.
- NFR2: Pipeline should complete in reasonable time with dependency caching.
- NFR3: Minimal runtime image footprint using multi-stage Docker build.

## 6. Success Metrics
- CI pass rate >= 95% on main branch over 30 days.
- Average CI duration within acceptable team threshold.
- Zero manual build/publish steps for standard changes.

## 7. Milestones
- M1: Project scaffold and test baseline.
- M2: CI workflow enabled.
- M3: Docker build and registry integration.
- M4: Release tagging and versioning strategy.

## 8. Risks
- Dependency download instability in CI environments.
- Registry auth/permission misconfiguration.
- Flaky tests causing pipeline instability.

## 9. Open Questions
- Which branch is the long-lived default (`main` or `master`)?
- Is automatic deploy required after image publish?
- What versioning policy should be enforced (SemVer/tag rules)?
