#!/bin/bash
#CLONE, INSTALL & CHANGE ENV FILE#
# Set your Azure DevOps credentials

username="Sathish.Selvaraj"
password="*******************"

# Set the IP address variable
ip_address="52.66.226.228"
subdomainIP="52.66.226.228"
subdomain="five"
branch="stage_10012024"

# Set the Git repository URL and UI directory
auth_url="dev.azure.com/kovaionai/timesheet-baseline/_git/auth"
directory="auth"
backend_url="dev.azure.com/kovaionai/Generic-Workflows/_git/generic-workflows-backend"
backend="generic-workflows-backend"
frontend_url="dev.azure.com/kovaionai/Generic-Workflows/_git/generic-workflows-frontend"
frontend="generic-workflows-frontend"

# Define the domains
frontenddomain="https://$subdomain.kovaion.ai"
backenddomain="https://$subdomain.kovaion.ai/backend/api/v1/"
authdomain="https://$subdomain.kovaion.ai/auth/api/v1/"
authdomain1="https://$subdomain.kovaion.ai/auth"

mongodb="mongodb+srv://doadmin:3TtE8eidr017926A@mongodb-prod-backup-19jan2024-990abcf7.mongo.ondigitalocean.com"
doadmin="doadmin:3TtE8eidr017926A@mongodb-prod-backup-19jan2024-990abcf7.mongo.ondigitalocean.com" #start from username ie omit the mongodb+srv://
admindb="superadmin"

# Define Redis Host and Port
REDIS_HOST="65.1.93.200"
REDIS_PORT="31233"
slug="f94eca9b-ad9d-42ec-861c-157631dad3ff" #resellerslug variable

# Exit immediately if any command exits with a non-zero status
set -e

set -x
# landing page - frontend .env.development src/router/index.js
#  auth src/routes/login/handler/login.controller.js - .env
#  Reseller slug - backend .env
#  admin_db=superadmin instead of demo-admin backend.env need to add entry
# sub_domain_prefix = q4-2023-stage (domainname) backend.env
#  mongodb url change in both backend and auth .env

#Preparation deleting the existing file
rm -rf /root/webhook/scripts/app

#Deleting existing PM2
#PM2 delete all

# Function to handle errors and print a message
handle_error() {
  echo "Error occurred in script at line $1"
}

# Trap for errors
trap 'handle_error $LINENO' ERR

# Update package lists
sudo apt update

# Install Git
sudo apt install git -y

# Install npm
sudo apt install npm -y

# Install n (Node.js version manager) and Node.js 14
sudo npm install -g n
sudo n install 18

# Install pm2 (Process Manager for Node.js applications)
sudo npm install -g pm2

#sudo apt-get install nodejs

# Install Nginx
sudo apt install nginx -y

# Install Certbot for Nginx
sudo apt install python3-certbot-nginx -y
# Run the Redis server

#sudo apt-get install redis-server
#redis-server

# Function to handle errors and print a message
handle_error() {
  echo "Error occurred in script at line $1"
}

# Trap for errors
trap 'handle_error $LINENO' ERR

mkdir app
cd app

#domainadd here


curl --location --request PUT "https://api.godaddy.com/v1/domains/kovaion.ai/records/A/$subdomain" \
--header "Accept: application/json, text/plain, */*" \
--header "Authorization: sso-key Aa96gVTYG9E_Nh9Z47aSvnbiCSAHQogR5q:DadvTbD9W2BNDioLx4xNte" \
--header "Content-Type: application/json" \
--header "User-Agent: axios/0.27.2" \
--header "Cookie: _abck=26AFF87C8B196A72801866D26E76125D~-1~YAAQP5UvF/lyx/OMAQAA9GqELwtfH1el98LGV4EXM64BAp9tTsWjhGJABmh5W89heg0E+yyiy6ekfefWGrOr1kfQRzVxSW0n2vvz8Bjev8p574gYHDbleIbhe+XD7nSH0HbEsT00Qy6gsQBLrOCHKoI01jQI9TRwOQtaVlxk2nz+5C+46ZhjLYU7QbT+bLTAiL4b5pEfK+VqXFZUITC8Po4DERn9VscVBLeHTVtGH/nlHNjCInPnRIrz4HyEHvlI/mvNB62lSryPCgiN1r/1fAHEblvaSVLnpxvs0smgi+oppnNP/1tpId0slIINnLg61Rwq8b+MqEp/x3vHQL2LpqDyUmTogiFWA0YUCUvBNpD4bBe2artNHYrVK+s+gezEc+MIPaREb1A=~-1~-1~-1; bm_sz=0C71C54489E623956A9E59D4F5962444~YAAQP5UvF/pyx/OMAQAA9GqELxZ7n9VWmKgPCJfgbqrPPUvsPGHNl/8yOiLw2tlfMpJf65ulHmxLQwYW+0NOvvdB4JAf6IoWQXhaZyyRVtkOWjQG8GUn9bnJaspre0/hf7n9q729VeWCXgz9tSXKfzhJcIklbtlDlNpK48XB+Zbbi6R6wpF70JrxyuIQNmI0RgROp2m+fEH//SNY/phQucJdK3k4YB/bfMG9q0dgQ3mA+14lYUhPPV14Bm/Xpg5zvqsCCuqfSJwAgiZ3fWiCPcWvW6jedkhqhYVOcjipedd/8EaUmDNImPEJea3+1Ft1GEfcJjjwO/AEZk4vfzHA~4534328~3552837" \
--data '[
    {
        "data": "'"$ip_address"'",
        "ttl": 600
    }
]'



##ssl here

# Clone the Git repository
echo "Cloning Git repository..."
auth_repo_url="https://${username}:${password}@$auth_url"
git clone -b "$branch" "$auth_repo_url"

# Change to the UI directory
cd "$directory"

# Install npm dependencies and force reinstall
npm install --force

cd ..

# Clone the Git repository
echo "Cloning Git repository..."
backend_repo_url="https://${username}:${password}@$backend_url"
git clone -b "$branch" "$backend_repo_url"

# Change to the UI directory
cd "$backend"

# Install npm dependencies and force reinstall
npm install --force

cd ..

rm -rf "$frontend"

# Clone the Git repository
echo "Cloning Git repository..."
frontend_repo_url="https://${username}:${password}@$frontend_url"
git clone -b "$branch" "$frontend_repo_url"

# Change to the UI directory
cd "$frontend"

# Install npm dependencies and force reinstall
npm install --force

# Specify the file path for the first file
FILE_PATH_1="/root/webhook/scripts/app/auth/.env"

# Use sed to replace the values in the first file
sed -i "s|FRONT_END_URL =.*|FRONT_END_URL = $frontenddomain|" "$FILE_PATH_1"
sed -i "s|FRONT_END_DOMAIN =.*|FRONT_END_DOMAIN = $frontenddomain|" "$FILE_PATH_1"
sed -i 's|DOMAIN_NAME[[:space:]]*=[[:space:]]*".*"|DOMAIN_NAME = "'"$subdomain"'"|' "$FILE_PATH_1"
sed -i "s|MAIN_DB_URL =.*|MAIN_DB_URL = $mongodb|" "$FILE_PATH_1"
sed -i "s|MAIN_HOST =.*|MAIN_HOST = $doadmin|" "$FILE_PATH_1"
#sed -i 's|SUB_DOMAIN[[:space:]]*=[[:space:]]*".*"|SUB_DOMAIN = "'"$subdomain"'"|' "$FILE_PATH_1"
sed -i "s|SUB_DOMAIN[[:space:]]*=[[:space:]]*\".*\"|SUB_DOMAIN = \"$subdomain\"|" "$FILE_PATH_1"

echo "Text in $FILE_PATH_1 updated successfully."

# Specify the file path for the second file
FILE_PATH_2="/root/webhook/scripts/app/generic-workflows-frontend/.env.development"

# Use sed to replace the values in the second file
sed -i "s|REACT_APP_API_BASE_URL=.*|REACT_APP_API_BASE_URL= $backenddomain|" "$FILE_PATH_2"
sed -i "s|REACT_APP_API_AUTH_URL =.*|REACT_APP_API_AUTH_URL = $authdomain|" "$FILE_PATH_2"
#sed -i "s|LANDING_PAGE=.*|LANDING_PAGE= "$subdomain"|" "$FILE_PATH_2"
sed -i "s|REACT_APP_LANDING_PAGE=.*|REACT_APP_LANDING_PAGE=\"$subdomain\"|" "$FILE_PATH_2"

echo "Text in $FILE_PATH_2 updated successfully."

FILE_PATH_3="/root/webhook/scripts/app/generic-workflows-backend/.env"

# Use sed to replace the values in the third file
sed -i "s|AUTH_API_URL[[:space:]]*=[[:space:]]*https://.*|AUTH_API_URL=$authdomain1|" "$FILE_PATH_3"
sed -i "s|FRONT_END_URL[[:space:]]*=[[:space:]]*https://.*|FRONT_END_URL=$frontenddomain|" "$FILE_PATH_3"
sed -i "s|REDIS_HOST[[:space:]]*=[[:space:]]*.*|REDIS_HOST=$REDIS_HOST|" "$FILE_PATH_3"
sed -i "s|REDIS_PORT[[:space:]]*=[[:space:]]*.*|REDIS_PORT=$REDIS_PORT|" "$FILE_PATH_3"
sed -i "s|RESELLER_SLUG[[:space:]]*=[[:space:]]*.*|RESELLER_SLUG=$slug|" "$FILE_PATH_3"
sed -i "s|SUB_DOAMIN_IP[[:space:]]*=[[:space:]]*.*|SUB_DOAMIN_IP=$subdomainIP|" "$FILE_PATH_3"
sed -i "s|MAIN_DB_URL =.*|MAIN_DB_URL = $mongodb|" "$FILE_PATH_3"
sed -i "s|DEMO_MAIN_HOST =.*|DEMO_MAIN_HOST = $mongodb|" "$FILE_PATH_3"
sed -i "s|^MAIN_HOST[[:space:]]*=[[:space:]]*.*|MAIN_HOST = $doadmin|" "$FILE_PATH_3"
sed -i "s|^SUB_DOMAIN_PREFIX[[:space:]]*=[[:space:]]*.*|SUB_DOMAIN_PREFIX = $subdomain|" "$FILE_PATH_3"
sed -i "s|^ADMIN_DB[[:space:]]*=[[:space:]]*.*|ADMIN_DB = $admindb|" "$FILE_PATH_3"

echo "Text in $FILE_PATH_3 updated successfully."


# Print versions at the end
echo "Installed versions:"
echo "Git: $(git --version)"
echo "npm: $(npm --version)"
echo "Node.js: $(node --version)"
echo "pm2: $(pm2 --version)"
echo "Nginx: $(nginx -v 2>&1)"
echo "Certbot: $(certbot --version)"


cd ..
#pm2 delete all

# Get the list of PM2 process IDs
#pm2_ids=$(pm2 list | awk '{if(NR>2)print $2}')

# Iterate over each process ID and delete it
#for id in $pm2_ids; do
#    pm2 delete $id
#done

cd /root/webhook/scripts/app/$directory
npm run build
#sudo cp /.env.auth .env

pm2 start "npm start" --name auth

cd
cd /root/webhook/scripts/app/$backend
#sudo cp /.env-backend ./.env
npm run build
pm2 start "npm start" --name backend

cd
cd /root/webhook/scripts/app/$frontend
npm run build
sudo cp -r build/* /var/www/html
pm2 start "npm start" --name frontend

# Install required packages
sudo apt install software-properties-common gnupg apt-transport-https ca-certificates -y

# Add MongoDB GPG key
curl -fsSL https://pgp.mongodb.com/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor --y

# Add MongoDB repository to sources list
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# Update package information
sudo apt update

# Install MongoDB
sudo apt install mongodb-org -y

# Start MongoDB service
sudo systemctl start mongod

# Check MongoDB service status
#sudo systemctl status mongod

# Check for MongoDB listening on port 27017
#sudo ss -pnltu | grep 27017

# Enable MongoDB to start on boot
#sudo systemctl enable mongod


mongodump --uri="mongodb+srv://doadmin:3TtE8eidr017926A@mongodb-prod-backup-19jan2024-990abcf7.mongo.ondigitalocean.com/engage?authSource=admin&replicaSet=mongodb-prod-backup-19jan2024&readPreference=primary&appname=MongoDB%20Compass&ssl=true" --out /home/my_dump

mongorestore --uri="mongodb+srv://doadmin:3TtE8eidr017926A@mongodb-prod-backup-19jan2024-990abcf7.mongo.ondigitalocean.com" -u doadmin -p 3TtE8eidr017926A --authenticationDatabase admin --db $subdomain-engage /home/my_dump/engage

nginx_sites_available="/etc/nginx/sites-available"

# Specify the name of the default file
default_file="default"

# New content for the file
new_content=$(cat <<EOL
server {
    listen 80;
    listen [::]:80;

    server_name $subdomain.kovaion.ai;
    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name $subdomain.kovaion.ai;

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

curl --location "https://$subdomain.kovaion.ai/backend/api/v1/tenant/client/addtenant" \
--header 'Content-Type: application/json' \
--data-raw '{
  "host": "doadmin:3TtE8eidr017926A@mongodb-prod-backup-19jan2024-990abcf7.mongo.ondigitalocean.com",
  "port": "",
  "client_name": "'"$subdomain-engage"'",
  "sub_domain": "'"$subdomain-engage"'",
  "dbname": "'"$subdomain-engage"'",
  "slug": "57989f64-8338-428f-9c61-24512b5b40e5",
  "tenant_name": "Kovaion_Consulting.kovaion",
  "email": "nk.murugesan@kovaion.com",
  "client_id": "639462717c29201e407b7b0e",
  "is_active": true,
  "entity_id": null,
  "updated_at": "2022-12-10T10:41:53.721Z",
  "updated_by": null,
  "created_by": null,
  "created_at": "2022-12-10T10:41:53.721Z"
}'


curl --location --request PUT "https://api.godaddy.com/v1/domains/kovaion.ai/records/A/$subdomain-engage" \
--header "Accept: application/json, text/plain, */*" \
--header "Authorization: sso-key Aa96gVTYG9E_Nh9Z47aSvnbiCSAHQogR5q:DadvTbD9W2BNDioLx4xNte" \
--header "Content-Type: application/json" \
--header "User-Agent: axios/0.27.2" \
--header "Cookie: _abck=26AFF87C8B196A72801866D26E76125D~-1~YAAQP5UvF/lyx/OMAQAA9GqELwtfH1el98LGV4EXM64BAp9tTsWjhGJABmh5W89heg0E+yyiy6ekfefWGrOr1kfQRzVxSW0n2vvz8Bjev8p574gYHDbleIbhe+XD7nSH0HbEsT00Qy6gsQBLrOCHKoI01jQI9TRwOQtaVlxk2nz+5C+46ZhjLYU7QbT+bLTAiL4b5pEfK+VqXFZUITC8Po4DERn9VscVBLeHTVtGH/nlHNjCInPnRIrz4HyEHvlI/mvNB62lSryPCgiN1r/1fAHEblvaSVLnpxvs0smgi+oppnNP/1tpId0slIINnLg61Rwq8b+MqEp/x3vHQL2LpqDyUmTogiFWA0YUCUvBNpD4bBe2artNHYrVK+s+gezEc+MIPaREb1A=~-1~-1~-1; bm_sz=0C71C54489E623956A9E59D4F5962444~YAAQP5UvF/pyx/OMAQAA9GqELxZ7n9VWmKgPCJfgbqrPPUvsPGHNl/8yOiLw2tlfMpJf65ulHmxLQwYW+0NOvvdB4JAf6IoWQXhaZyyRVtkOWjQG8GUn9bnJaspre0/hf7n9q729VeWCXgz9tSXKfzhJcIklbtlDlNpK48XB+Zbbi6R6wpF70JrxyuIQNmI0RgROp2m+fEH//SNY/phQucJdK3k4YB/bfMG9q0dgQ3mA+14lYUhPPV14Bm/Xpg5zvqsCCuqfSJwAgiZ3fWiCPcWvW6jedkhqhYVOcjipedd/8EaUmDNImPEJea3+1Ft1GEfcJjjwO/AEZk4vfzHA~4534328~3552837" \
--data '[
    {
        "data": "'"$ip_address"'",
        "ttl": 600
    }
]'
