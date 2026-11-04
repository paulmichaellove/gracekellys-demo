#!/usr/bin/env bash
# Deploys the Grace Kelly's demo to GitHub Pages. Run from this folder by Paul.
set -euo pipefail
cd "$(dirname "$0")"

gh auth status

gh repo create paulmichaellove/gracekellys-demo --public --source=. --push

gh api -X POST repos/paulmichaellove/gracekellys-demo/pages -f build_type=legacy -f "source[branch]=main" -f "source[path]=/"

gh api -X PUT repos/paulmichaellove/gracekellys-demo/pages -f cname=gracekellys.paulmichaellove.com

cat <<'EOF'

DNS RECORD TO ADD IN KAJABI (DNS Settings for paulmichaellove.com):
  Type:   CNAME
  Host:   gracekellys
  Target: paulmichaellove.github.io

FOLLOW-UP once the certificate exists (check Settings > Pages shows "DNS check successful" and the cert is issued), enforce https:
  gh api -X PUT repos/paulmichaellove/gracekellys-demo/pages -F https_enforced=true
EOF
