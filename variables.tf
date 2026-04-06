/*----------------------------------------------------------------------*/
/* Common |                                                             */
/*----------------------------------------------------------------------*/

variable "metadata" {
  type = any
}

/*----------------------------------------------------------------------*/
/* Route53 | Variable Definition                                        */
/*----------------------------------------------------------------------*/
variable "route53_parameters" {
  type        = any
  description = "Route53 parameteres to declare records in hosted zone"
  default     = {}
}

variable "route53_defaults" {
  type        = any
  description = "Route53 default parameteres to declare hosted zone"
  default     = {}
}

variable "vpc_parameter" {
  type        = any
  description = "VPC wrapper-style map: `vpcs.<key>.vpc_id`. Private zones need `vpc_id` or `vpc` (key into `vpcs`)."
  default     = {}
}
