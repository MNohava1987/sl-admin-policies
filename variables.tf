variable "supported_manifest_versions" {
  type        = list(string)
  default     = ["1"]
  description = "Allowed manifest schema versions."
}

variable "enable_component" {
  type        = bool
  default     = true
  description = "Global feature flag for this component."
}

variable "enable_deletion_protection" {
  type        = bool
  default     = false
  description = "DANGER: If false, managed resources may be deleted. Keep true for normal operations."
}

variable "repave_mode" {
  type        = bool
  default     = true
  description = "Set true only for intentional teardown/repave operations when deletion protection is disabled."
}
