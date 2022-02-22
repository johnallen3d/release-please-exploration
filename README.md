# Release Please Exploration

## Discovery

- (👍) What is `github` style CHANGELOG : slightly different format, requires PR workflow
- (❓) Multiple branches/environments : ??? does this even make sense? a release should be defined as a production deployment or new package version
- (👍) Tracking a version file for a web/api based project : this can be done by specifying a `version-file`

## Assumptions

- We are using [GitHub Flow]() or similar (feature branch -> default branch workflow)
- The default branch is named `main`

## Workflow

- merging into `main` deploys to a non-production environment (e.g. `qa`, `stage` ...)
- commits on `main` (via PR merge) causes CHANGELOG / version file PR to be opened (Release Please)
- merging a release PR causes a production deployment


