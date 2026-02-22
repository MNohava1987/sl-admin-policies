locals {
  manifest_path = "${path.module}/manifests/policies-config.yaml"
  manifest      = yamldecode(file(local.manifest_path))

  cfg_enable_component           = try(local.manifest.settings.enable_component, var.enable_component)
  cfg_enable_deletion_protection = try(local.manifest.settings.enable_deletion_protection, var.enable_deletion_protection)
}
