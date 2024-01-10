#!/bin/bash

# Specify the path to the Nginx sites-available directory
nginx_sites_available="/etc/nginx/sites-available"

# Specify the name of the default file
default_file="default"

# New content for the file
new_content=$(cat <<EOL
server {
    listen 80;
    listen [::]:80;

    server_name stage6.kovaion.ai;
    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name stage6.kovaion.ai;

    ssl_certificate /etc/letsencrypt/live/kovaion.ai/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/kovaion.ai/privkey.pem;

    # Enable SSL
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 5m;

    # Use modern TLS protocols
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers off;

    # Use strong ciphers
    ssl_ciphers 'TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384';

    # Enable OCSP stapling
    ssl_stapling on;
    ssl_stapling_verify on;
    resolver 8.8.8.8;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }

    location /backend/ {
        proxy_pass http://localhost:8000/;
        # Add additional proxy settings as needed
    }

    location /auth/ {
        proxy_pass http://localhost:8080/;
        # Add additional proxy settings as needed
    }
}

EOL
)

# Overwrite the content of the default file
echo "$new_content" > "$nginx_sites_available/$default_file"

# Restart Nginx to apply changes
systemctl restart nginx

echo "Nginx configuration has been updated and Nginx has been restarted."


