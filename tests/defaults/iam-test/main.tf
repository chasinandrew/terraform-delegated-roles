# module "iam-binding" {
#     source = "../.."
#     member = "group:test_priv_read@andrewchasin.joonix.net"
#     role = "roles/dns.reader"
# }

# module "iam-binding-2" {
#     source = "../.."
#     member = "group:test_priv_read@andrewchasin.joonix.net"
#     role = "roles/dns.reader"
# }

module "iam-binding" {
  source = "../../../project-iam-member-CONSUMER/groups/privileged_read"
  member = "group:test@andrewchasin.joonix.net"
  roles = ["roles/run.invoker", "roles/dns.reader"]
}