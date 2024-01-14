mkdir -p ~/.secrets/certbot/
echo "dns_cloudflare_api_key = your_cloudflare_api_key" > ~/.secrets/certbot/cloudflare.ini
echo "dns_cloudflare_email = your_cloudflare_email" >> ~/.secrets/certbot/cloudflare.ini
chmod 600 ~/.secrets/certbot/cloudflare.ini
