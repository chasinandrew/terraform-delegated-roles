locals {
  project_id = var.project_id
  members    = var.members
  default_roles = []
  conditional_roles = [
    "roles/run.invoker",
    "roles/run.developer", 
    "roles/cloudbuild.builds.approver",
    "roles/datacatalog.categoryFineGrainedReader",
    "roles/eventarc.viewer",
    "roles/cloudsql.viewer",
    "roles/storage.objectCreator",
    "roles/dns.reader",
    "roles/logging.privateLogViewer",
    "roles/logging.viewer",
    "roles/monitoring.dashboardViewer",
    "roles/notebooks.legacyViewer",
    "roles/notebooks.runner",
    "roles/notebooks.viewer",
    "roles/ml.developer",
    "roles/ml.jobOwner",
    "roles/ml.modelOwner",
    "roles/ml.modelUser",
    "roles/ml.operationOwner",
    "roles/ml.viewer",
    "roles/appengine.appCreator", 
    "roles/appengine.appViewer", 
    "roles/appengine.codeViewer",
    "roles/appengine.deployer",
    "roles/appengine.memcacheDataAdmin",
    "roles/appengine.serviceAdmin",
    "roles/artifactregistry.reader",
    "roles/artifactregistry.writer",
    "roles/bigquery.connectionUser",
    "roles/bigquery.dataEditor",
    "roles/bigquery.dataOwner",
    "roles/bigquery.dataViewer",
    "roles/bigquery.filteredDataViewer",
    "roles/bigquery.jobUser",
    "roles/bigquery.metadataViewer",
    "roles/bigquery.readSessionUser",
    "roles/bigquery.resourceEditor",
    "roles/bigquery.resourceViewer",
    "roles/bigquery.user",
    "roles/binaryauthorization.policyViewer",
    "roles/bigtable.reader",
    "roles/bigtable.user",
    "roles/bigtable.viewer",
    "roles/composer.environmentAndStorageObjectViewer",
    "roles/cloudsql.editor",
    "roles/cloudsql.client",
    "roles/cloudsql.viewer",
    "roles/storage.hmacKeyAdmin",
    "roles/storage.objectCreator",
    "roles/storage.objectViewer",
    "roles/storagetransfer.transferAdmin",
    "roles/storagetransfer.user",
    "roles/tpu.viewer",
    "roles/tpu.xpnAgent",
    "roles/compute.imageUser",
    "roles/compute.instanceAdmin",
    "roles/compute.loadBalancerAdmin",
    "roles/compute.networkUser",
    "roles/compute.networkViewer",
    "roles/compute.orgFirewallPolicyUser",
    "roles/compute.orgSecurityPolicyUser",
    "roles/compute.osLogin",
    "roles/compute.packetMirroringUser",
    "roles/compute.soleTenantViewer",
    "roles/compute.viewer",
    "roles/osconfig.guestPolicyViewer",
    "roles/osconfig.instanceOSPoliciesComplianceViewer",
    # "roles/osconfig.inventoryViewer",
    # "roles/osconfig.osPolicyAssignmentReportViewer",
    # "roles/osconfig.osPolicyAssignmentViewer",
    # "roles/osconfig.patchDeploymentViewer",
    # "roles/osconfig.patchJobViewer",
    # "roles/osconfig.vulnerabilityReportViewer",
    # "roles/storage.legacyBucketWriter"
  ]
}

module "delegated-roles-100" {
  source     = "../.."
  project_id = local.project_id
  additive_conditional_bindings = [{
    "members"           = local.members
    "conditional_roles" = local.conditional_roles
  }]
  additive_default_bindings = [{
    "members"           = local.members
    "role"              = local.default_roles
  }]
}

