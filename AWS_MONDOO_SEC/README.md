# AWS Security Demo Project

This repo demonstrates:
- Infrastructure as Code (Terraform)
- Static analysis with Checkov
- Secure deployments with GitHub Actions (approval gates)
- Runtime/cloud scanning with Mondoo (`cnspec`)
- Policy-as-code using YAML

## Pipeline Stages
1. **Checkov Scan** – runs only if `checkovScan == true`. Outputs JUnit results.
2. **Terraform Plan & Apply** – requires manual approval before apply.
3. **Terraform Destroy** – runs only if `enableDestroy == true`.
4. **Mondoo Scan** – runs only if `enableMondoo == true`.validates resources against built-in and custom policies.

## Custom Mondoo Policies
See `policies/custom-s3-sg.mql.yaml`:
- No S3 public ACLs
- No SG open SSH (0.0.0.0/0:22)

## Cleanup
To avoid charges, destroy resources via workflow (`enableDestroy == true`).