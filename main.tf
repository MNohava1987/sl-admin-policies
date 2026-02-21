# --- GLOBAL DATA LOOKUP ---
# Identify the root space so we can apply global laws.
data "spacelift_space_by_path" "root" {
  space_path = "root"
}

# --- GLOBAL PUSH POLICY ---
# This policy governs how runs are triggered and cleaned up account-wide.
resource "spacelift_policy" "global_push_flow" {
  name        = "global-git-flow"
  type        = "GIT_PUSH"
  body        = file("${path.module}/policies/push/global_flow.rego")
  description = "Enforces main-only deployments and auto-discards redundant queued runs."
}

# Attach Global Push Policy to Root Space (Inherited by all stacks)
resource "spacelift_policy_attachment" "global_push" {
  policy_id = spacelift_policy.global_push_flow.id
  space_id  = data.spacelift_space_by_path.root.id
}

# --- ENVIRONMENT GUARD POLICY ---
# Prevents cross-environment deployments (e.g. dev branch to prod env).
resource "spacelift_policy" "branch_env" {
  name        = "branch-env-guard"
  type        = "PLAN"
  body        = file("${path.module}/policies/branch_env.rego")
  description = "Blocks apply if the VCS branch does not match the stack environment label."
}

# Attach Environment Guard to Root (Global inheritance)
resource "spacelift_policy_attachment" "branch_env_global" {
  policy_id = spacelift_policy.branch_env.id
  space_id  = data.spacelift_space_by_path.root.id
}
