module "wrapper_route53" {
  source = "../../"

  metadata = local.metadata

  route53_parameters = {
    zones = {
      "${local.zone_public}" = {
        private = false
      }

      "${local.zone_private}" = {
        private = true
        vpc     = "networking"
        # Or: vpc_id = "vpc-xxxxxxxxxxxxxx"
      }
    }
  }

  # Should come from wrapper_vpc (e.g. `vpc_parameter = { vpcs = module.wrapper_vpc.vpcs }`). Hardcoded here only so this example is self-contained.
  vpc_parameter = {
    vpcs = {
      networking = { vpc_id = "vpc-xxxxxxxxxxxxxx" }
    }
  }
}
