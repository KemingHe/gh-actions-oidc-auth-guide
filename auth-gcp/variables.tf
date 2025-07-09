variable "github_repo" {
  type        = string
  description = "The GitHub repository in 'owner/repo' format authorized to authenticate with Google Cloud."

  validation {
    condition     = can(regex("^[a-zA-Z0-9._-]+/[a-zA-Z0-9._-]+$", var.github_repo))
    error_message = "The github_repo must be in 'owner/repo' format (e.g., 'myorg/myrepo')."
  }
}

variable "gcp_project_id" {
  type        = string
  description = "The target Google Cloud project ID for resource creation and management."

  validation {
    condition     = can(regex("^[a-z0-9-]{6,30}$", var.gcp_project_id))
    error_message = "The gcp_project_id must be 6-30 characters long and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "service_account_id" {
  type        = string
  description = "The unique ID for the Google Cloud Service Account. Must be 6-30 characters, lowercase letters, numbers, and hyphens."
  default     = "github-actions-sa"

  validation {
    condition     = can(regex("^[a-z0-9-]{6,30}$", var.service_account_id))
    error_message = "The service_account_id must be 6-30 characters long and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "wif_pool_id" {
  type        = string
  description = "The unique ID for the Workload Identity Pool. Must be 4-32 characters, lowercase letters, numbers, and hyphens."
  default     = "github-actions-pool"

  validation {
    condition     = can(regex("^[a-z0-9-]{4,32}$", var.wif_pool_id))
    error_message = "The wif_pool_id must be 4-32 characters long and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "wif_provider_id" {
  type        = string
  description = "The unique ID for the Workload Identity Federation Provider. Must be 4-32 characters, lowercase letters, numbers, and hyphens."
  default     = "github-actions-provider"

  validation {
    condition     = can(regex("^[a-z0-9-]{4,32}$", var.wif_provider_id))
    error_message = "The wif_provider_id must be 4-32 characters long and contain only lowercase letters, numbers, and hyphens."
  }
}
