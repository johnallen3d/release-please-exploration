# Release Please Application Deployment

Reference application using [GitHub Actions](https://github.com/features/actions) and [Release Please](https://github.com/googleapis/release-please) to deploy a [Docker](https://www.docker.com/) based application.

## Assumptions

- The default branch is named `main`
- You are using [GitHub Flow](https://docs.github.com/en/get-started/quickstart/github-flow) or similar (feature branch -> default branch)

## Workflows

Workflow definitions for GitHub Actions are located in [`.github/workflows/`](.github/workflows/)

### Build

[`build-lint-test-deploy.yml`](.github/workflows/build-lint-test-deploy.yml)

This workflow runs on all Pull Requests (PRs) targeted at the default branch as well as on pushes (merges into) the default branch.

#### Workflow Steps

1. Checkout code for the current branch (feature branch for PR or default branch after merge)
1. Run any required setup steps[^1] (build test images, define environment variables)
1. Lint the codebase[^1]
1. Run tests[^1]
1. Log into Docker image registry[^2][^3]
1. Build Docker image and push to registry[^3]
1. Run the release script[^4] (targeting deployment into a staging environment)

### Release Please

[`release-please.yml`](.github/workflows/release-please.yml)

Release Please is a tool built and maintained by Google that can automate the following release related tasks for your repo. Release Please relies heavily on commits following the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) format.

1. Add relevant updates to the projects [`CHANGELOG.md`](./CHANGELOG.md)
1. Update a [version file](./app/version.rb), following [Semantic Versioning](https://semver.org/)
1. Generate and update [release PR](https://github.com/johnallen3d/release-please-exploration/pull/20) with the above changes
1. Create [GitHub Releases](https://github.com/johnallen3d/release-please-exploration/releases/tag/v1.4.0) upon merge of generated PRs

This wofkflow runs on all pushes to the default branch.

#### Workflow Steps

1. Interrogate recent push and generate/update release PR where appropriate[^5]

### Deploy to Production

[`deploy-to-prod.yml`](.github/workflows/deploy-to-prod.yml)

This workflow runs after a Release Please generated PR is merged into the default branch (signaling a release).

#### Workflow Steps

1. Checkout code for the default branch
1. Log into Docker image registry[^2][^3]
1. Run the release script[^4] (targeting deployment into a production environment)

[^1]: This step is mocked out in the reference workflow
[^2]: In this example we are using Docker Hub
[^3]: This step only runs after a PR merge into the default branch
[^4]: In this example we are using Heroku
[^5]: Appropriate commits are "user facing" (`feat`/`fix` yes, `chore`/`build` no)
