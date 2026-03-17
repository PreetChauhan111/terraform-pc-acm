# terraform-pc-acm

A Terraform wrapper module for provisioning AWS ACM (Certificate Manager) certificates using the [terraform-aws-modules/acm/aws](https://registry.terraform.io/modules/terraform-aws-modules/acm/aws/latest) module.

## Usage

```hcl
module "acm" {
  source  = "./terraform-pc-acm"

  domain_name               = "example.com"
  subject_alternative_names = ["www.example.com", "api.example.com"]
  zone_id                   = "Z1234567890ABC"
  validation_method         = "DNS"

  tags = {
    Environment = "dev"
    Project     = "my-project"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| acm | terraform-aws-modules/acm/aws | 6.3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| acm_certificate_domain_validation_options | A list of domain_validation_options created by the ACM certificate to create required Route53 records from it (used when create_route53_records_only is set to true) | `any` | `{}` | no |
| certificate_transparency_logging_preference | Specifies whether certificate details should be added to a certificate transparency log | `bool` | `true` | no |
| create_certificate | Whether to create ACM certificate | `bool` | `true` | no |
| create_route53_records | When validation is set to DNS, define whether to create the DNS records internally via Route53 or externally using any DNS provider | `bool` | `true` | no |
| create_route53_records_only | Whether to create only Route53 records (e.g. using separate AWS provider) | `bool` | `false` | no |
| distinct_domain_names | List of distinct domains and SANs (used when create_route53_records_only is set to true) | `list(string)` | `[]` | no |
| dns_ttl | The TTL of DNS recursive resolvers to cache information about this record. | `number` | `60` | no |
| domain_name | A domain name for which the certificate should be issued | `string` | `""` | no |
| export | Whether the certificate can be exported. Valid values are ENABLED or DISABLED (default). Note Issuing an exportable certificate is subject to additional charges | `string` | `null` | no |
| key_algorithm | Specifies the algorithm of the public and private key pair that your Amazon issued certificate uses to encrypt data | `string` | `null` | no |
| private_authority_arn | Private Certificate Authority ARN for issuing private certificates | `string` | `null` | no |
| region | Region to create the resources into | `string` | `null` | no |
| subject_alternative_names | A list of domains that should be SANs in the issued certificate | `list(string)` | `[]` | no |
| tags | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| validate_certificate | Whether to validate certificate by creating Route53 record | `bool` | `true` | no |
| validation_allow_overwrite_records | Whether to allow overwrite of Route53 records | `bool` | `true` | no |
| validation_method | Which method to use for validation. DNS or EMAIL are valid. This parameter must not be set for certificates that were imported into ACM and then into Terraform. | `string` | `null` | no |
| validation_option | The domain name that you want ACM to use to send you validation emails. This domain name is the suffix of the email addresses that you want ACM to use. | `any` | `{}` | no |
| validation_record_fqdns | When validation is set to DNS and the DNS validation records are set externally, provide the fqdns for the validation | `list(string)` | `[]` | no |
| validation_timeout | Define maximum timeout to wait for the validation to complete | `string` | `null` | no |
| wait_for_validation | Whether to wait for the validation to complete | `bool` | `true` | no |
| zone_id | The ID of the hosted zone to contain this record. Required when validating via Route53 | `string` | `""` | no |
| zones | Map containing the Route53 Zone IDs for additional domains. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| acm_certificate_arn | The ARN of the certificate |
| acm_certificate_domain_validation_options | A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used. |
| acm_certificate_status | Status of the certificate. |
| acm_certificate_validation_emails | A list of addresses that received a validation E-Mail. Only set if EMAIL-validation was used. |
| distinct_domain_names | List of distinct domains names used for the validation. |
| validation_domains | List of distinct domain validation options. This is useful if subject alternative names contain wildcards. |
| validation_route53_record_fqdns | List of FQDNs built using the zone domain and name. |
