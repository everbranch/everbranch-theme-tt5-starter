#!/usr/bin/env bash
set -euo pipefail

# Idempotent initial content setup for a fresh site.
# Requires: wp-cli within the running container/context.

# Create essential pages if not present
wp post list --post_type=page --field=post_title | grep -qi "Terms" || wp post create --post_type=page --post_status=publish --post_title="Terms & Conditions"
wp post list --post_type=page --field=post_title | grep -qi "Privacy" || wp post create --post_type=page --post_status=publish --post_title="Privacy Policy"
wp post list --post_type=page --field=post_title | grep -qi "Contact" || wp post create --post_type=page --post_status=publish --post_title="Contact" --post_content="<p>Contact us at <a href=\"mailto:contact@everbranch.co\">contact@everbranch.co</a></p>"

# Assign privacy policy page if not set
pid=$(wp post list --post_type=page --name=privacy-policy --field=ID || true)
if [ -n "$pid" ]; then wp option update wp_page_for_privacy_policy "$pid" || true; fi

# Pretty permalinks
wp rewrite structure "/%postname%/" --hard || true

# Flush rewrite
wp rewrite flush --hard || true
