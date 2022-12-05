locals {
  project_id = "arched-inkwell-368821"
  roles = yamldecode(file("${path.module}/roles.yaml"))
}

resource "google_project_iam_member" "project_iam_additive" {
  for_each =  {for t in local.roles : t.test => t}
  project = local.project_id
  member = var.member
  role = each.value
}

# resource "google_project_iam_member" "project_iam_additive" {
#   for_each = toset(local.roles)
#   project  = local.project_id
#   member   = var.member
#   role     = each.value
# }

