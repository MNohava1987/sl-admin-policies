variable "spacelift_api_key_id" { type = string; sensitive = true }
variable "spacelift_api_key_secret" { type = string; sensitive = true }

# Example: attach to these parent spaces so children inherit
variable "baseline_space_ids" { type = list(string) default = ["gcp","azure"] }
