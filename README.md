# GitHub Actions Cloud IaC Pipelines

A reusable, enterprise-grade CI/CD platform for cloud infrastructure deployment using Terraform and GitHub Actions. This repository provides standardized workflows that support both Azure and AWS, promoting code through dev, qa, and prod environments with consistent logic and secure practices.

## Features

- **Reusable Workflows**: Standardized `plan` and `apply` logic shared across all projects.
- **Multi-Cloud Support**: Native support for Azure (OIDC) and AWS (IAM Roles/Secrets).
- **Environment Promotion**: Clean separation of configurations using `.tfvars` files.
- **Secure by Design**: Integration with GitHub Environments for manual approvals and secret isolation.
- **Modern Authentication**: Supports Azure OIDC for secret-less authentication.

## Folder Structure

```text
├── .github/
│   └── workflows/
│       ├── terraform-plan-reusable.yml   # Reusable Plan logic
│       ├── terraform-apply-reusable.yml  # Reusable Apply logic
│       └── main-deploy.yml               # Entry point workflow
├── templates/
│   ├── azure/                            # Standard Azure TF template
│   └── aws/                              # Standard AWS TF template
└── docs/                                 # Detailed guides
```

## How to Onboard

To use these workflows in your repository:

1.  **Define Environments**: Create `dev`, `qa`, and `prod` environments in your GitHub repository settings.
2.  **Configure Secrets**:
    - Add cloud credentials (`AZURE_CLIENT_ID`, `AWS_ACCESS_KEY_ID`, etc.) as environment secrets.
    - Add `TF_BACKEND_CONFIG` as a secret (e.g., `resource_group_name=rg-tf-state\nstorage_account_name=sttfstate`).
3.  **Place your Terraform**: Put your code in a subdirectory (e.g., `/infra`).
4.  **Create variables**: Ensure you have an `environments/` folder inside your infra directory with `dev.tfvars`, `prod.tfvars`, etc.
5.  **Call the workflow**: Create a `.github/workflows/deploy.yml` in your repo and call the reusable workflows as shown in `main-deploy.yml`.

## Best Practices

### Naming Conventions
- **Resources**: `resourcetype-projectname-environment` (e.g., `vnet-mentormint-prod`).
- **Workflows**: Use descriptive names like `Terraform Plan - dev`.

### Secret Management
- Use **GitHub Environments** to isolate secrets between dev and prod.
- Prefer **OIDC** (OpenID Connect) for Azure and AWS to avoid long-lived access keys.

### Pipeline Logic
- **No Manual Changes**: The pipeline logic never changes between environments; only the inputs and secrets change.
- **Plan Preservation**: Always run `terraform apply` on the exact plan artifact generated in the `plan` stage.

## Example Repository Layout

```text
YourRepo/
├── .github/workflows/deploy.yml  # Calls reusable workflows from this repo
├── infra/
│   ├── main.tf
│   ├── variables.tf
│   └── environments/
│       ├── dev.tfvars
│       └── prod.tfvars
```
