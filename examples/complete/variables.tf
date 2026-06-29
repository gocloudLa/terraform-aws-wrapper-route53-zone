/*----------------------------------------------------------------------*/
/* Common |                                                             */
/*----------------------------------------------------------------------*/

# variable "metadata" {
#   type = any
# }

/*----------------------------------------------------------------------*/
/* Route53 | Variable Definition                                        */
/*----------------------------------------------------------------------*/
variable "route53_parameters" {
  type        = any
  description = "Route53 parameters to declare hosted zone"
  default     = {}
}

variable "route53_defaults" {
  type        = any
  description = "Route53 default parameters to declare hosted zone"
  default     = {}
}
