locals {
  # create_zone = true (default) → create hosted zone (+ optional authorizations)
  zones_create_tmp = [
    for zone_key, zone_config in var.route53_parameters : {
      "${zone_key}" = {
        private = try(zone_config.private, var.route53_defaults.private, false)
        tags    = try(zone_config.tags, var.route53_defaults.tags, null)
        vpcs = try(zone_config.private, var.route53_defaults.private, false) ? merge(
          {
            primary = {
              vpc_id     = try(zone_config.vpc_id, var.vpc_parameter.vpcs[zone_config.vpc].vpc_id)
              vpc_region = try(zone_config.vpc_region, var.route53_defaults.vpc_region, null)
            }
          },
          {
            for auth_key, auth_config in try(zone_config.vpc_association_authorizations, {}) :
            auth_key => {
              vpc_id     = auth_config.vpc_id
              vpc_region = try(auth_config.vpc_region, var.route53_defaults.vpc_region, null)
            } if try(auth_config.active, false)
          }
        ) : {}
      }
    } if try(zone_config.create_zone, var.route53_defaults.create_zone, true)
  ]
  zones_create = merge(local.zones_create_tmp...)

  vpc_association_authorizations_tmp = [
    for zone_key, zone_config in var.route53_parameters : [
      for auth_key, auth_config in try(zone_config.vpc_association_authorizations, {}) : {
        "${zone_key}/${auth_key}" = {
          zone_name  = zone_key
          vpc_id     = auth_config.vpc_id
          vpc_region = try(auth_config.vpc_region, var.route53_defaults.vpc_region, null)
        }
      }
    ] if try(zone_config.create_zone, var.route53_defaults.create_zone, true) && length(try(zone_config.vpc_association_authorizations, {})) > 0
  ]
  vpc_association_authorizations = merge(flatten(local.vpc_association_authorizations_tmp)...)

  # Associate when zone_association is declared (VPC-owner / accepter side)
  zones_associate_tmp = [
    for zone_key, zone_config in var.route53_parameters : {
      "${zone_key}" = {
        zone_id    = zone_config.zone_association.zone_id
        vpc_id     = try(zone_config.zone_association.vpc_id, var.vpc_parameter.vpcs[zone_config.zone_association.vpc].vpc_id)
        vpc_region = try(zone_config.zone_association.vpc_region, var.route53_defaults.vpc_region, null)
      }
    } if try(zone_config.create_zone, true) == false && try(zone_config.zone_association, null) != null
  ]
  zones_associate = merge(local.zones_associate_tmp...)
}
