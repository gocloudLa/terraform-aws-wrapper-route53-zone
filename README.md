# Standard Platform - Terraform Module 🚀🚀
<p align="right"><a href="https://partners.amazonaws.com/partners/0018a00001hHve4AAC/GoCloud"><img src="https://img.shields.io/badge/AWS%20Partner-Advanced-orange?style=for-the-badge&logo=amazonaws&logoColor=white" alt="AWS Partner"/></a><a href="LICENSE"><img src="https://img.shields.io/badge/License-Apache%202.0-green?style=for-the-badge&logo=apache&logoColor=white" alt="LICENSE"/></a></p>

Welcome to the Standard Platform — a suite of reusable and production-ready Terraform modules purpose-built for AWS environments.
Each module encapsulates best practices, security configurations, and sensible defaults to simplify and standardize infrastructure provisioning across projects.

## 📦 Module: Terraform Route53 Zone Module
<p align="right"><a href="https://github.com/gocloudLa/terraform-aws-wrapper-route53-zone/releases/latest"><img src="https://img.shields.io/github/v/release/gocloudLa/terraform-aws-wrapper-route53-zone.svg?style=for-the-badge" alt="Latest Release"/></a><a href=""><img src="https://img.shields.io/github/last-commit/gocloudLa/terraform-aws-wrapper-route53-zone.svg?style=for-the-badge" alt="Last Commit"/></a><a href="https://registry.terraform.io/modules/gocloudLa/wrapper-route53-zone/aws"><img src="https://img.shields.io/badge/Terraform-Registry-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform Registry"/></a></p>
Wrapper module for AWS Route53 that simplifies the creation and management of public and private hosted zones. Supports VPC association for private zones through direct VPC IDs or VPC wrapper integration.


### ✨ Features

- 🌐 [Public Hosted Zone](#public-hosted-zone) - Create public DNS zones accessible from the internet.

- 🔒 [Private Hosted Zone with VPC Association](#private-hosted-zone-with-vpc-association) - Create private DNS zones scoped to a VPC.




## 🚀 Quick Start
```hcl
route53_parameters = {
  zones = {
    "lab.democorp.cloud" = {
      private = false
    }

    "lab.democorp" = {
      private = true
      vpc     = "networking"
      # Or: vpc_id = "vpc-xxxxxxxxxxxxxx"
    }
  }
}
```


## 🔧 Additional Features Usage

### Public Hosted Zone
Creates an `aws_route53_zone` resource for each entry in the `zones` map where `private = false`. The zone domain name is derived from the map key.


<details><summary>Public zone</summary>

```hcl
route53_parameters = {
  zones = {
    "lab.democorp.cloud" = {
      private = false
    }
  }
}
```


</details>


### Private Hosted Zone with VPC Association
When `private = true`, the module associates the zone with a VPC via a dynamic `vpc` block. Supply the VPC ID directly with `vpc_id`, or reference a VPC by key from the `vpc_parameter.vpcs` map (output of the VPC wrapper). Both options are mutually exclusive — `vpc_id` takes precedence when both are present.


<details><summary>Private zone via VPC wrapper key</summary>

```hcl
route53_parameters = {
  zones = {
    "lab.democorp" = {
      private = true
      vpc     = "networking"
    }
  }
}
```


</details>

<details><summary>Private zone via direct VPC ID</summary>

```hcl
route53_parameters = {
  zones = {
    "lab.democorp" = {
      private = true
      vpc_id  = "vpc-xxxxxxxxxxxxxx"
    }
  }
}
```


</details>




## 📑 Inputs
| Name    | Description                                                                               | Type          | Default | Required |
| ------- | ----------------------------------------------------------------------------------------- | ------------- | ------- | -------- |
| zones   | Map of zone domain name → zone config. The map key is the hosted zone domain name.        | `map`         | `{}`    | yes      |
| private | Set to `true` to create a private hosted zone associated with a VPC.                      | `bool`        | `false` | no       |
| vpc     | Key into `vpc_parameter.vpcs` map used to resolve the VPC ID for private zones.           | `string`      | `null`  | no       |
| vpc_id  | Direct VPC ID for private zone association. Used when not consuming a VPC wrapper output. | `string`      | `null`  | no       |
| tags    | Map of tags applied to all zones managed by this invocation.                              | `map(string)` | `null`  | no       |







## ⚠️ Important Notes
- ⚠️ **Private zones require a VPC:** set either `vpc` (key into `vpc_parameter.vpcs`) or `vpc_id` when `private = true`; omitting both will cause a plan-time error.
- ℹ️ **Name server delegation:** public zones return NS records that must be registered at your domain registrar before DNS resolution is functional.



---

## 🤝 Contributing
We welcome contributions! Please see our contributing guidelines for more details.

## 🆘 Support
- 📧 **Email**: info@gocloud.la

## 🧑‍💻 About
We are focused on Cloud Engineering, DevOps, and Infrastructure as Code.
We specialize in helping companies design, implement, and operate secure and scalable cloud-native platforms.
- 🌎 [www.gocloud.la](https://www.gocloud.la)
- ☁️ AWS Advanced Partner (Terraform, DevOps, GenAI)
- 📫 Contact: info@gocloud.la

## 📄 License
This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details. 