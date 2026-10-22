# Lab NN: Title

**Source:** NextWork / self-built · **Date:** YYYY-MM-DD · **Time spent:** Xh · **Cost:** $X.XX

## Goal

One or two sentences: what this lab builds and why it matters.

## Architecture

![Architecture diagram](diagram.png)

## What I built

- Resource and the key setting that matters (for example: VPC 10.0.0.0/16, two public subnets across two AZs)

## How to deploy

```bash
cd terraform
terraform init
terraform apply
```

## How I verified it

Commands and results that prove it works: ping, traceroute, curl, route tables, flow logs. Screenshots go in `screenshots/`.

## What broke and how I fixed it

The most useful section for interviews. What went wrong, how you found it, what you changed.

## Cost and teardown

```bash
terraform destroy
```

Anything that bills by the hour (NAT gateway, interface endpoints, VPN) and confirmation it was removed.

## What I'd do in production

Changes for a real environment: multi-AZ, least-privilege, monitoring, naming and tagging.
