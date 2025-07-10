variable "github_repo" {
  type        = string
  description = "The GitHub repository in 'owner/repo' format authorized to authenticate with Google Cloud"

  validation {
    condition     = can(regex("^[a-zA-Z0-9]([a-zA-Z0-9._-]*[a-zA-Z0-9])?/[a-zA-Z0-9]([a-zA-Z0-9._-]*[a-zA-Z0-9])?$", var.github_repo))
    error_message = "The github_repo must be in 'owner/repo' format with valid GitHub naming conventions (e.g., 'myorg/myrepo')."
  }
}

variable "gcp_project_id" {
  type        = string
  description = "The target Google Cloud project ID for resource creation and management"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.gcp_project_id))
    error_message = "The gcp_project_id must be 6-30 characters long, start with a lowercase letter, cannot end with a hyphen, and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "service_account_id" {
  type        = string
  description = "The unique ID for the Google Cloud Service Account (must be 6-30 characters, lowercase letters, numbers, and hyphens)"
  default     = "github-actions-sa"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{5,29}$", var.service_account_id))
    error_message = "The service_account_id must be 6-30 characters long, start with a lowercase letter, and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "wif_pool_id" {
  type        = string
  description = "The unique ID for the Workload Identity Pool (must be 4-32 characters, lowercase letters, numbers, and hyphens)"
  default     = "github-actions-pool"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{3,31}$", var.wif_pool_id))
    error_message = "The wif_pool_id must be 4-32 characters long, start with a lowercase letter, and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "wif_provider_id" {
  type        = string
  description = "The unique ID for the Workload Identity Federation Provider (must be 4-32 characters, lowercase letters, numbers, and hyphens)"
  default     = "github-actions-provider"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{3,31}$", var.wif_provider_id))
    error_message = "The wif_provider_id must be 4-32 characters long, start with a lowercase letter, and contain only lowercase letters, numbers, and hyphens."
  }
}
