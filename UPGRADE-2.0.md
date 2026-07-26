# Upgrade from v1.x to v2.0

If you have a question regarding this upgrade process, please check the code in the `examples/complete` directory.

If you found a bug, please open an issue in this repository.

## List of Changes

1. **Input interface** – `route53_parameters.zones` nesting was removed. Zone entries are now keys of `route53_parameters` directly.
2. **Private zone VPC** – the root-level `vpc_id` argument was removed. Set `vpc` or `vpc_id` inside each private zone entry.

## Example upgrade procedure

### Legacy (v1.x) `main.tf`

```hcl
route53_parameters = {
  zones = {
    "lab.democorp.cloud" = {
      private = false
    }

    "lab.democorp" = {
      private = true
    }
  }
}

vpc_id = "vpc-xxxxxxxxxxxxxx"
```

### New (v2.0) `main.tf`

```hcl
route53_parameters = {
  "lab.democorp.cloud" = {
    private = false
  }

  "lab.democorp" = {
    private = true
    vpc     = "networking"
    # Or: vpc_id = "vpc-xxxxxxxxxxxxxx"
  }
}
```
