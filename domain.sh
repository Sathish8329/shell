#!/bin/bash

# Replace these variables with your actual values
CF_API_KEY="*****"
CF_EMAIL="sathish.selvaraj@kovaion.com"
CF_ZONE_ID="****"
SUBDOMAIN="stage12"
DOMAIN="kovaion.ai"
EC2_IP="13.235.59.8"

# Create a DNS record in Cloudflare for the subdomain with proxying enabled
curl -X POST "https://api.cloudflare.com/client/v4/zones/$CF_ZONE_ID/dns_records" \
     -H "Content-Type: application/json" \
     -H "X-Auth-Key: $CF_API_KEY" \
     -H "X-Auth-Email: $CF_EMAIL" \
     --data '{"type":"A","name":"'"$SUBDOMAIN"'","content":"'"$EC2_IP"'","ttl":120,"proxied":true}'
