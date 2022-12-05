locals { 
    project_id = "arched-inkwell-368821"
}

# module "provision-delegated-iam" {
#     source = "app.terraform.io/hca-healthcare/delegated-role-granting/conditional-roles" 
#     project_id = module.hca-dsa-dev.project_id
#     members = [format("serviceAccount:%s",module.hca-dsa-dev-sa.iam_email)] 
#     depends_on = [module.hca-dsa-dev-sa, module.hca-dsa-dev]
# }

module "delegated-role-granting" {
    source = "../../../conditional-roles/service-accounts"
    project_id = local.project_id
    members = [format("serviceAccount:%s", google_service_account.service_account.email)]
} 

resource "google_service_account" "service_account" {
    account_id = "limited-admin-demo"
    display_name = "Service Account for testing DRG"
    project = local.project_id
}

resource "google_project_iam_member" "service_account_creator" {
    project = local.project_id
    role = "roles/iam.serviceAccountCreator"
    member = format("serviceAccount:%s", google_service_account.service_account.email)
    depends_on = [
      google_service_account.service_account
    ]
}

resource "google_project_iam_member" "service_account_deleter" {
    project = local.project_id
    role = "roles/iam.serviceAccountDeleter"
    member = format("serviceAccount:%s", google_service_account.service_account.email)
    depends_on = [
      google_service_account.service_account
    ]
}


