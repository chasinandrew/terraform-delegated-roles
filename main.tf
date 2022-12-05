#It will group the roles based on the CHUNK Size and all the groups are combined with "or" operator

locals {
  project_id = var.project_id
  # enable_apis = var.enable_apis
  #Chunk size must be set to 10 as this is the maximum amount of conditional bindings per request
  CHUNK_SIZE = 10

  # additive_conditional_binding is a list of map. This will apply the conditions for the respective role is passed or else will be default to empty
  additive_conditional_bindings = [
    for binding in var.additive_conditional_bindings : {
      role    = "roles/resourcemanager.projectIamAdmin"
      members = [binding.members]
      #if the binding has conditional roles, enter the for loop. If not, return blank string. 
      conditions = contains(keys(binding), "conditional_roles") ? join("||", flatten([
        for l in chunklist(formatlist("'%s'", binding.conditional_roles), local.CHUNK_SIZE) : [
          format("api.getAttribute('iam.googleapis.com/modifiedGrantsByRole', []).hasOnly([%s])", join(", ", l))
        ]
      ])) : ""
    }
  ]
  # Additive_default_bindings is a list of maps and will be adding bindings to the respective member
  additive_default_bindings = [
    for binding in var.additive_default_bindings : {
      # for role in roles : {
      role       = binding.role
      members    = [binding.members]
      conditions = [""]
      # }
    }
  ]
  # #Additive_member_bindings is a list of maps and will be adding bindings to the respective member
  additive_member_bindings = [
    for binding in var.additive_member_bindings : {
      # for role in roles : {
      role       = binding.role
      members    = [binding.members]
      conditions = [""]
      # }
    }
  ]
  #Concat All the values from the list of variables and pass it as a list of values to computed bindings
  additive_computed_bindings = flatten(concat(local.additive_conditional_bindings)) //, local.additive_default_bindings, local.additive_member_bindings))
}

#Values of computed bindings will be assigned dynamically for the resource which is additive
resource "google_project_iam_member" "project_iam_additive" {
  for_each = { for idx, v in local.additive_computed_bindings : idx => v }
  project  = local.project_id
  role     = each.value.role
  member   = join(",", element(each.value.members, each.key))
  dynamic "condition" {
    for_each = each.value.conditions == "" ? [] : [each.value.conditions]
    content {
      title       = "Limit projectIAMAdmin permissions"
      description = "Limiting access to project IAM Admin member"
      expression  = each.value.conditions
    }
  }
}
