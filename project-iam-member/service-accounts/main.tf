resource "google_project_iam_member" "project_iam_additive" {
  # for_each = { for idx, v in local.additive_computed_bindings : idx => v }
  project  = local.project_id
  role     = "roles/run.invoker"
  member   = "serviceAccount:test-sa@projectid.com"
}