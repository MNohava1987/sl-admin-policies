# --- GLOBAL DATA LOOKUP ---
# Identify the root space ID.
data "spacelift_space_by_path" "root" {
  space_path = "root"
}

# --- GLOBAL PUSH POLICY ---
# Created in the root space, this policy is automatically inherited 
# by every stack in the account.
resource "spacelift_policy" "global_push_flow" {
  name        = "global-git-flow"
  type        = "GIT_PUSH"
  body        = file("${path.module}/policies/push/global_flow.rego")
  description = "Enforces main-only deployments and auto-discards redundant queued runs."
  space_id    = data.spacelift_space_by_path.root.id
}

# --- ENVIRONMENT GUARD POLICY ---
# Created in the root space for global enforcement.
resource "spacelift_policy" "branch_env" {
  name        = "branch-env-guard"
  type        = "PLAN"
  body        = file("${path.module}/policies/branch_env.rego")
  description = "Blocks apply if the VCS branch does not match the stack environment label."
  space_id    = data.spacelift_space_by_path.root.id
}
