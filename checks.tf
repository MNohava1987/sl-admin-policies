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

check "destructive_changes_require_repave_mode" {
  assert {
    condition     = local.cfg_enable_deletion_protection || var.repave_mode
    error_message = "Disabling deletion protection requires repave_mode=true for explicit operator intent."
  }
}
