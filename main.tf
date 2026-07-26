resource "aws_route53_zone" "this" {
  for_each = local.zones_create

  name = each.key

  dynamic "vpc" {
    for_each = each.value.vpcs

    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = vpc.value.vpc_region
    }
  }

  tags = merge(local.common_tags, try(each.value.tags, null))
}

resource "aws_route53_vpc_association_authorization" "this" {
  for_each = local.vpc_association_authorizations

  zone_id    = aws_route53_zone.this[each.value.zone_name].zone_id
  vpc_id     = each.value.vpc_id
  vpc_region = each.value.vpc_region
}

resource "aws_route53_zone_association" "this" {
  for_each = local.zones_associate

  zone_id    = each.value.zone_id
  vpc_id     = each.value.vpc_id
  vpc_region = each.value.vpc_region
}
