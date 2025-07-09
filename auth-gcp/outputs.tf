# =============================================================================
# TERRAFORM OUTPUTS
# =============================================================================
# These outputs provide the values needed to configure GitHub Actions secrets

output "service_account_email" {
  description = "Email of the service account for GitHub Actions authentication"
  value       = google_service_account.github_actions_sa.email
  sensitive   = false
}

output "workload_identity_provider_name" {
  description = "Full resource name of the Workload Identity Provider for OIDC token exchange"
  value       = google_iam_workload_identity_pool_provider.provider.name
  sensitive   = false
}

output "setup_instructions" {
  description = "Instructions for configuring GitHub Actions secrets"
  value       = <<-EOT
    Configure these GitHub repository secrets:
    
    1. GCP_SERVICE_ACCOUNT: ${google_service_account.github_actions_sa.email}
    2. GCP_WORKLOAD_IDENTITY_PROVIDER: ${google_iam_workload_identity_pool_provider.provider.name}
    
    Then use in your GitHub Actions workflow:
    
    - name: Authenticate to GCP
      uses: 'google-github-actions/auth@v2.1.10'
      with:
        workload_identity_provider: $${{ secrets.GCP_WORKLOAD_IDENTITY_PROVIDER }}
        service_account: $${{ secrets.GCP_SERVICE_ACCOUNT }}
  EOT
  sensitive   = false
}
