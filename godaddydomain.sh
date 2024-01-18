#!/bin/bash

# Replace these variables with your actual values
GODADDY_API_KEY="Aa96gVTYG9E_Nh9Z47aSvnbiCSAHQogR5q"
GODADDY_API_SECRET="DadvTbD9W2BNDioLx4xNte"
DOMAIN="kovaion.ai"
SUBDOMAIN="stage12"
RECORD_TYPE="A"
TTL="600"
DATA="{\"data\":\"YOUR_EC2_IP\",\"ttl\":$TTL,\"priority\":0,\"port\":1,\"weight\":0}"

# Create a DNS record in GoDaddy for the subdomain
curl -X PATCH "https://api.godaddy.com/v1/domains/$DOMAIN/records/$RECORD_TYPE/$SUBDOMAIN" \
     -H "Content-Type: application/json" \
     -H "Authorization: sso-key $GODADDY_API_KEY:$GODADDY_API_SECRET" \
     --data $DATA

