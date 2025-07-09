# =============================================================================
# GITHUB ACTIONS OIDC AUTHENTICATION TO GCP
# =============================================================================

# Local values for consistent resource naming and configuration
locals {
  # Member principal for Workload Identity Federation
  wif_member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.pool.name}/attribute.repository/${var.github_repo}"

  # Service account email reference
  service_account_member = "serviceAccount:${google_service_account.github_actions_sa.email}"
}

# -----------------------------------------------------------------------------
# REQUIRED API SERVICES
# -----------------------------------------------------------------------------

resource "google_project_service" "core_apis" {
  for_each = toset([
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com",
  ])

  project                    = var.gcp_project_id
  service                    = each.key
  disable_dependent_services = true
  disable_on_destroy         = false
}

# -----------------------------------------------------------------------------
# SERVICE ACCOUNT
# -----------------------------------------------------------------------------

resource "google_service_account" "github_actions_sa" {
  project      = var.gcp_project_id
  account_id   = var.service_account_id
  display_name = "GitHub Actions Service Account"
  description  = "Service account for GitHub Actions OIDC authentication via Workload Identity Federation"

  depends_on = [google_project_service.core_apis]
}

# -----------------------------------------------------------------------------
# WORKLOAD IDENTITY FEDERATION
# -----------------------------------------------------------------------------

resource "google_iam_workload_identity_pool" "pool" {
  project                   = var.gcp_project_id
  workload_identity_pool_id = var.wif_pool_id
  display_name              = "GitHub Actions Identity Pool"
  description               = "Identity pool for GitHub Actions OIDC authentication"
  disabled                  = false

  depends_on = [google_project_service.core_apis]
}

resource "google_iam_workload_identity_pool_provider" "provider" {
  project                            = var.gcp_project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.wif_provider_id
  display_name                       = "GitHub OIDC Provider"
  description                        = "OIDC identity provider for GitHub Actions authentication"
  disabled                           = false

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
    "attribute.ref"              = "assertion.ref"
    "attribute.actor"            = "assertion.actor"
  }

  # Restrict access to the specified repository only
  attribute_condition = "assertion.repository == '${var.github_repo}'"
}

# -----------------------------------------------------------------------------
# IAM BINDINGS FOR WORKLOAD IDENTITY
# -----------------------------------------------------------------------------

# Allow the GitHub Actions principal to impersonate the service account
resource "google_service_account_iam_member" "wif_user" {
  service_account_id = google_service_account.github_actions_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = local.wif_member
}

# Allow the principal to generate access tokens for the service account
resource "google_service_account_iam_member" "wif_token_creator" {
  service_account_id = google_service_account.github_actions_sa.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = local.wif_member
}
