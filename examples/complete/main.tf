# Workspace / state A — account that owns the private hosted zone (authorization).
module "wrapper_route53" {
  source = "../../"

  metadata = local.metadata

  route53_parameters = {
    "${local.zone_public}" = {
      private = false
    }

    "${local.zone_private}" = {
      private = true
      vpc     = "prod"
      # Or: vpc_id = "vpc-xxxxxxxxxxxxxx"

      # vpc_association_authorizations = {
      #   networking = {
      #     vpc_id = "vpc-02xxxxxxxxxxxxx" # Remote vpc_id (other account)
      #     # vpc_region = "us-east-2"
      #     # active = true # Default: false. Set true after the VPC-owner association exists (clears drift).
      #   }
      # }
    }
  }

  # Should come from wrapper_vpc (e.g. `vpc_parameter = { vpcs = module.wrapper_vpc.vpcs }`). Hardcoded here only so this example is self-contained.
  vpc_parameter = {
    vpcs = {
      prod = { vpc_id = "vpc-01xxxxxxxxxxxxx" }
    }
  }
}

# # Workspace / state B — account that owns the VPC (association / accept).
# # Apply after the authorization from module "wrapper_route53" exists.
# module "wrapper_route53_accepter" {
#   source = "../../"
#
#   metadata = local.metadata
#
#   route53_parameters = {
#     "${local.zone_private}" = {
#       create_zone = false
#       zone_association = {
#         zone_id = "ZXXXXXXXXXXXXX" # Hosted zone ID from the owner account
#         vpc     = "networking"
#         # Or: vpc_id = "vpc-02xxxxxxxxxxxxx"
#         # vpc_region = "us-east-2"
#       }
#     }
#   }
#
#   vpc_parameter = {
#     vpcs = {
#       networking = { vpc_id = "vpc-02xxxxxxxxxxxxx" }
#     }
#   }
# }
