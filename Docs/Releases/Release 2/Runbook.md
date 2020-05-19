# Runbook for release deployment

## Before Release

- [ ] Terraform Ready - platform
- [ ] Terraform Ready - Azure Platform
- [ ] Secrets files prepped - Azure Platform
- [ ] Make note of WAF rules to apply
- [ ] Make static files ready (with & without login enabled on public browse)
- [ ] Merge all (not platform) repos to master
- [ ] Collect final build number from master for all docker files
- [ ] Apply final build number to static files
- [ ] SQL Update for COntent fix
- [ ] PDF for content fix
- [ ] Compare Document
- [ ] K8s release script
- [ ] Example admin user for prod
- [ ] Example buyer user for prod
- [ ] Work out how to trigger email

## Release Stage 1: WAF Rules

- [ ] Manually apply WAF rules to private & Public gateway
- [ ] Terraform plan prod & double check not updating gateways

## Release Stage 2: Terraform

- [ ] Terraform Apply to Prod
- [ ] Get Redis Details & finalise pipeline variables

## Release Stage 3: Apply static Files & Update with login enabled

- [ ] Run static file release script - Private
- [ ] Upload compare doc & content change pdf - Private
- [ ] Smoke test Private system working
  - [ ] Check marketing pages working
  - [ ] Check public browse working
  - [ ] validate content changes
  - [ ] validate pdf
  - [ ] validate compare doc
- [ ] Run static file release script - Public
- [ ] Upload compare doc & content change pdf - Public
- [ ] Smoke Test Public System with Login
  - [ ] Check public browse working
  - [ ] validate content changes
  - [ ] validate pdf
  - [ ] validate compare doc
  - [ ] login as admin user
    - [ ] Check organisations
    - [ ] Check Specific Organisation page
  - [ ] Login as buyer user
    - [ ] Check orders page
  - [ ] Somehow trigger an email send & validate

## Release Stage 4: Apply static Files & Update with login enabled

- [ ] Run static file release script - Public for pb with login disabled
- [ ] Smoke test pb

## Post Release

- [ ] Merge platform to master
- [ ] Merge Azure Platform to master