# ===================================================================
# APPLICATION-SPECIFIC PERMISSIONS
# ===================================================================
# This file contains templates for granting the service account
# permissions needed for your specific application or use case.
# Uncomment and add/delete the examples below as needed.

# -------------------------------------------------------------------
# Additional API Services
# -------------------------------------------------------------------
# Enable additional Google Cloud APIs required for your application

# resource "google_project_service" "additional_apis" {
#   for_each = toset([
#     "storage.googleapis.com",               # Cloud Storage
#     "cloudbuild.googleapis.com",            # Cloud Build
#     "run.googleapis.com",                   # Cloud Run
#     "artifactregistry.googleapis.com",      # Artifact Registry
#     "secretmanager.googleapis.com",         # Secret Manager
#     "cloudresourcemanager.googleapis.com",  # Resource Manager
#   ])
#
#   project                    = var.gcp_project_id
#   service                    = each.key
#   disable_dependent_services = true
#   disable_on_destroy         = false
# }

# -------------------------------------------------------------------
# Common IAM Role Examples
# -------------------------------------------------------------------

# Storage Admin - Full control over Cloud Storage
# resource "google_project_iam_member" "storage_admin" {
#   project = var.gcp_project_id
#   role    = "roles/storage.admin"
#   member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
# }

# Cloud Build Editor - Create and manage builds
# resource "google_project_iam_member" "cloudbuild_editor" {
#   project = var.gcp_project_id
#   role    = "roles/cloudbuild.builds.editor"
#   member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
# }

# Cloud Run Developer - Deploy and manage Cloud Run services
# resource "google_project_iam_member" "cloudrun_developer" {
#   project = var.gcp_project_id
#   role    = "roles/run.developer"
#   member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
# }

# Artifact Registry Writer - Push container images and artifacts
# resource "google_project_iam_member" "artifactregistry_writer" {
#   project = var.gcp_project_id
#   role    = "roles/artifactregistry.writer"
#   member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
# }

# Secret Manager Secret Accessor - Read secrets
# resource "google_project_iam_member" "secretmanager_accessor" {
#   project = var.gcp_project_id
#   role    = "roles/secretmanager.secretAccessor"
#   member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
# }

# -------------------------------------------------------------------
# Resource-Specific Permissions
# -------------------------------------------------------------------

# Example: Grant access to specific Cloud Storage bucket
# resource "google_storage_bucket_iam_member" "deployment_bucket_admin" {
#   bucket = "your-deployment-bucket"
#   role   = "roles/storage.objectAdmin"
#   member = "serviceAccount:${google_service_account.github_actions_sa.email}"
# }

# Example: Grant access to specific Secret Manager secret
# resource "google_secret_manager_secret_iam_member" "app_secret_accessor" {
#   secret_id = "your-app-secret"
#   role      = "roles/secretmanager.secretAccessor"
#   member    = "serviceAccount:${google_service_account.github_actions_sa.email}"
# }

# -------------------------------------------------------------------
# Custom Roles (Advanced)
# -------------------------------------------------------------------

# Example: Create a custom role with minimal required permissions
# resource "google_project_iam_custom_role" "github_actions_custom" {
#   role_id     = "githubActionsCustom"
#   title       = "GitHub Actions Custom Role"
#   description = "Custom role with minimal permissions for GitHub Actions"
#   permissions = [
#     "storage.objects.create",
#     "storage.objects.delete",
#     "storage.objects.get",
#     "storage.objects.list",
#   ]
# }

# resource "google_project_iam_member" "github_actions_custom" {
#   project = var.gcp_project_id
#   role    = google_project_iam_custom_role.github_actions_custom.id
#   member  = "serviceAccount:${google_service_account.github_actions_sa.email}"
# }
