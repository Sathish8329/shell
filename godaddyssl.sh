#!/bin/bash

# Replace these variables with your actual values
GODADDY_API_KEY="Aa96gVTYG9E_Nh9Z47aSvnbiCSAHQogR5q"
GODADDY_API_SECRET="DadvTbD9W2BNDioLx4xNte"
DOMAIN="kovaion.ai"

# Run Certbot to obtain the wildcard certificate
sudo certbot certonly \
  --non-interactive \
  --agree-tos \
  --email nk.murugesan@kovaion.com \
  --dns-godaddy \
  --dns-godaddy-credentials ~/.secrets/certbot/godaddy.ini \
  -d "*.$DOMAIN"

# Renew the certificate (add this to cron to automate renewal)
sudo certbot renew
