# Cloud Networking Lab

Hands-on AWS networking labs, documented end to end: architecture diagrams, verification steps, lessons learned, and Terraform.

I'm studying cloud networking on the way to a DevOps or cloud network engineering role. Every lab here is something I built and tested in my own AWS account, then tore down.

[![CI](https://github.com/nick-networks/cloud-networking-lab/actions/workflows/terraform-ci.yml/badge.svg)](https://github.com/nick-networks/cloud-networking-lab/actions/workflows/terraform-ci.yml)
![License: MIT](https://img.shields.io/badge/license-MIT-blue)

## About me

<!-- Two or three sentences: background, what roles you're targeting, LinkedIn link. -->

## Skills shown

| Skill | Where to see it |
| --- | --- |
| VPC design: subnets, route tables, internet and NAT gateways | [01](labs/01-build-a-vpc), [03](labs/03-private-subnet) |
| Traffic control: security groups, network ACLs | [02](labs/02-vpc-traffic-flow-and-security) |
| Connectivity testing and troubleshooting | [05](labs/05-test-vpc-connectivity) |
| VPC peering | [06](labs/06-vpc-peering) |
| Observability with VPC Flow Logs | [07](labs/07-vpc-flow-logs) |
| Private access to AWS services: gateway and interface endpoints | [08](labs/08-access-s3-from-vpc), [09](labs/09-vpc-endpoints) |
| Content delivery with CloudFront | [10](labs/10-cloudfront-delivery) |
| Hub-and-spoke with Transit Gateway, hybrid VPN, private DNS, load balancing | [11 to 14](labs) |
| Infrastructure as code with Terraform, CI checks on every pull request | [iac](iac), [.github/workflows](.github/workflows) |

## Lab index

| # | Lab | Source | Status |
| --- | --- | --- | --- |
| 01 | [Build a VPC](labs/01-build-a-vpc) | NextWork | Not started |
| 02 | [VPC traffic flow and security](labs/02-vpc-traffic-flow-and-security) | NextWork | Not started |
| 03 | [Private subnet](labs/03-private-subnet) | NextWork | Not started |
| 04 | [Launch VPC resources](labs/04-launch-vpc-resources) | NextWork | Not started |
| 05 | [Test VPC connectivity](labs/05-test-vpc-connectivity) | NextWork | Not started |
| 06 | [VPC peering](labs/06-vpc-peering) | NextWork | Not started |
| 07 | [VPC Flow Logs](labs/07-vpc-flow-logs) | NextWork | Not started |
| 08 | [Access S3 from a VPC](labs/08-access-s3-from-vpc) | NextWork | Not started |
| 09 | [VPC endpoints](labs/09-vpc-endpoints) | NextWork | Not started |
| 10 | [CloudFront delivery](labs/10-cloudfront-delivery) | NextWork | Not started |
| 11 | [Transit Gateway hub-and-spoke](labs/11-transit-gateway-hub-spoke) | Self-built, Terraform | Planned |
| 12 | [Site-to-site VPN](labs/12-site-to-site-vpn) | Self-built, Terraform | Planned |
| 13 | [Route 53 private DNS](labs/13-route53-private-dns) | Self-built, Terraform | Planned |
| 14 | [Load balancing: ALB and NLB](labs/14-load-balancing-alb-nlb) | Self-built, Terraform | Planned |

Labs 01 to 10 follow the [NextWork AWS roadmap](https://nextwork.ai/portfolio/illusionmenon/learnlists/056ca688-f91c-528c-b3ab-bf69849c9876). The write-ups, diagrams and Terraform are my own.

## Certifications

See [certs/](certs). No exams booked yet.

## Roadmap and progress

Work is tracked in GitHub Issues, milestones and a Projects board. See [ROADMAP.md](ROADMAP.md) for the phases.

## Running a lab

1. Install the AWS CLI and Terraform, and configure credentials with `aws configure` (never commit them).
2. `cd labs/<lab>/terraform && terraform init && terraform apply`
3. Follow the verification steps in the lab README.
4. **Tear down when finished:** `terraform destroy`. NAT gateways, endpoints and VPNs bill by the hour.

## Repo layout

```
labs/        one folder per lab: README, diagram, terraform/, screenshots/
projects/    bigger builds that combine several labs, plus DevOps projects
notes/       study notes (fundamentals, AWS)
certs/       certification plans and results
diagrams/    shared diagrams
iac/modules/ reusable Terraform modules
scripts/     helper scripts
```
