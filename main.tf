# Create policy and attach to parent spaces (inheritance model)

resource "spacelift_policy" "branch_env" {
  name        = "branch-env-apply-guard"
  type        = "PLAN" # __FILL_ME__: pick correct policy type for your rule
  body        = file("${path.module}/policies/branch_env.rego")
  description = "Blocks apply if branch doesn't match environment."
}

# Attach baseline policy to parent spaces (children inherit).
resource "spacelift_policy_attachment" "baseline" {
  for_each  = toset(var.baseline_space_ids)
  policy_id = spacelift_policy.branch_env.id
  space_id  = each.value
}
