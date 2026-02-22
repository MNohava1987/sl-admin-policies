# --- Manifest Contracts ---

check "manifest_version_supported" {
  assert {
    condition     = contains(var.supported_manifest_versions, try(local.manifest.manifest_version, "missing"))
    error_message = "Manifest version is missing or unsupported."
  }
}

check "component_enabled_flag_boolean" {
  assert {
    condition     = can(tobool(local.cfg_enable_component))
    error_message = "settings.enable_component must be boolean."
  }
}

check "deletion_protection_flag_boolean" {
  assert {
    condition     = can(tobool(local.cfg_enable_deletion_protection))
    error_message = "settings.enable_deletion_protection must be boolean."
  }
}
