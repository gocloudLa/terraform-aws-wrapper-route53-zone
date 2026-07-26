# Workspace / state A — account that owns the private hosted zone.
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

      vpc_association_authorizations = {
        # # Same AWS account — set active = true; association is done here (no zone_association needed).
        # peer = {
        #   vpc_id = "vpc-02xxxxxxxxxxxxx"
        #   # vpc_region = "us-east-2"
        #   active = true
        # }

        # # Cross-account — leave active = false until the VPC-owner workspace runs zone_association.
        # networking = {
        #   vpc_id = "vpc-03xxxxxxxxxxxxx" # Remote vpc_id (other account)
        #   # vpc_region = "us-east-2"
        #   # active = true # Set true after the VPC-owner association exists (clears drift).
        # }
      }
    }
  }

  # Should come from wrapper_vpc (e.g. `vpc_parameter = { vpcs = module.wrapper_vpc.vpcs }`). Hardcoded here only so this example is self-contained.
  vpc_parameter = {
    vpcs = {
      prod = { vpc_id = "vpc-01xxxxxxxxxxxxx" }
    }
  }
}

# # Workspace / state B — VPC owner (cross-account only).
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
#         zone_id = "ZXXXXXXXXXXXXX"
#         vpc     = "networking"
#         # Or: vpc_id = "vpc-03xxxxxxxxxxxxx"
#         # vpc_region = "us-east-2"
#       }
#     }
#   }
#
#   vpc_parameter = {
#     vpcs = {
#       networking = { vpc_id = "vpc-03xxxxxxxxxxxxx" }
#     }
#   }
# }
