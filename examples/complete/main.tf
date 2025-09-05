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
      }
    }
  }

  # Should come as output from the wrapper_vpc module.
  # vpc_id = module.wrapper_vpc.vpc.vpc_id
  vpc_id = "vpc-xxxxxxxxxxxxxx"

}
