#!/usr/bin/env bash
# One-time GitHub setup for nick-networks/cloud-networking-lab.
# Needs the GitHub CLI signed in: gh auth status
# The Projects board step needs the project scope: gh auth refresh -s project
set -euo pipefail

REPO="nick-networks/cloud-networking-lab"
OWNER="nick-networks"

echo "== Repo description, topics, security =="
gh repo edit "$REPO" \
  --description "Hands-on AWS networking labs with diagrams, write-ups and Terraform" \
  --add-topic aws --add-topic networking --add-topic vpc --add-topic terraform \
  --add-topic devops --add-topic cloud --add-topic infrastructure-as-code \
  --enable-issues --enable-projects --enable-wiki=false \
  --delete-branch-on-merge --enable-squash-merge --enable-merge-commit=false --enable-rebase-merge=false

# Secret scanning and push protection (free on public repos)
gh api -X PATCH "repos/$REPO" --input - <<'JSON'
{"security_and_analysis":{"secret_scanning":{"status":"enabled"},"secret_scanning_push_protection":{"status":"enabled"}}}
JSON
gh api -X PUT "repos/$REPO/vulnerability-alerts" >/dev/null
gh api -X PUT "repos/$REPO/automated-security-fixes" >/dev/null

echo "== Labels =="
label() { gh label create "$1" --repo "$REPO" --color "$2" --description "$3" --force; }
label "type: lab"       "1D76DB" "A hands-on build"
label "type: study"     "0E8A16" "Reading, course module, notes"
label "type: cert"      "5319E7" "Exam prep or booking"
label "type: docs"      "C5DEF5" "README or write-up polish"
label "type: chore"     "BFDADC" "CI, tooling, cleanup"
label "cloud: aws"      "FF9900" "AWS"
label "cloud: azure"    "0078D4" "Azure"
label "topic: vpc"      "FBCA04" "VPC, subnets, route tables"
label "topic: routing"  "FBCA04" "Routing, peering, Transit Gateway"
label "topic: dns"      "FBCA04" "Route 53 and DNS"
label "topic: vpn"      "FBCA04" "Hybrid connectivity"
label "topic: security" "D93F0B" "Security groups, NACLs, IAM"
label "topic: iac"      "FBCA04" "Terraform"
label "priority: high"  "B60205" "Do this week"

echo "== Milestones =="
milestone() {
  if ! gh api "repos/$REPO/milestones?state=all" --jq '.[].title' | grep -qxF "$1"; then
    gh api -X POST "repos/$REPO/milestones" -f title="$1" -f description="$2" >/dev/null
  fi
  echo "  $1"
}
milestone "M0 Repo setup"               "Structure, README, templates, CI, security settings"
milestone "M1 Networking fundamentals"  "Subnetting, TCP/IP, DNS, BGP basics"
milestone "M2 AWS core networking"      "Labs 01 to 10 (NextWork VPC series)"
milestone "M3 Advanced and hybrid"      "Labs 11 to 14, built in Terraform"
milestone "M4 Certification"            "Cert to be chosen"
milestone "M5 Capstone"                 "Multi-VPC hub-and-spoke project"
milestone "M6 Second cloud"             "Azure equivalents (optional)"

echo "== Issues for labs 01 to 10 =="
lab_issue() {
  local title="$1" topic="$2"
  if ! gh issue list --repo "$REPO" --state all --search "\"$title\" in:title" --json title --jq '.[].title' | grep -qxF "$title"; then
    gh issue create --repo "$REPO" --title "$title" --milestone "M2 AWS core networking" \
      --label "type: lab" --label "cloud: aws" --label "$topic" \
      --body "NextWork project. Follow the [lab template](https://github.com/nick-networks/cloud-networking-lab/blob/main/labs/_template/README.md) and the definition of done in the Lab issue form."
  fi
}
lab_issue "Lab 01: Build a VPC"                       "topic: vpc"
lab_issue "Lab 02: VPC traffic flow and security"     "topic: security"
lab_issue "Lab 03: Private subnet"                    "topic: vpc"
lab_issue "Lab 04: Launch VPC resources"              "topic: vpc"
lab_issue "Lab 05: Test VPC connectivity"             "topic: vpc"
lab_issue "Lab 06: VPC peering"                       "topic: routing"
lab_issue "Lab 07: VPC Flow Logs"                     "topic: vpc"
lab_issue "Lab 08: Access S3 from a VPC"              "topic: vpc"
lab_issue "Lab 09: VPC endpoints"                     "topic: vpc"
lab_issue "Lab 10: Website delivery with CloudFront"  "topic: vpc"

echo "== Projects board =="
if gh auth status 2>&1 | grep -q "'project'"; then
  if ! gh project list --owner "$OWNER" --format json --jq '.projects[].title' | grep -qxF "Cloud Networking Lab"; then
    num=$(gh project create --owner "$OWNER" --title "Cloud Networking Lab" --format json --jq '.number')
    gh project link "$num" --owner "$OWNER" --repo "$REPO"
    gh project field-create "$num" --owner "$OWNER" --name "Hours spent" --data-type NUMBER
    echo "  Created project #$num. Add the columns in the web UI (see SETUP.md)."
  else
    echo "  Project already exists."
  fi
else
  echo "  Skipped: run 'gh auth refresh -s project' and re-run this script."
fi

echo "Done."
