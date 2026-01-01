#!/bin/bash

# Startup Warning
echo "Server Handler Install Script"
echo "Starting in 5 seconds..."
sleep 5

# Updating and Upgrading
echo "Updating and Upgrading..."
sleep 1
apt update
apt upgrade -y

# Installing Requirements
echo "Installing Requirements..."
sleep 1
apt install curl wget unzip git libcurl4 -y

# Installing Bun
echo "Installing bun..."
sleep 1
curl -fsSL https://bun.com/install | bash
source /root/.bashrc

# Installing Server Handler
echo "Installing Server Handler..."
sleep 1
git clone https://github.com/Executive-Hosting/server-handler.git /root/server-handler/

# Installing Server Handler Dependencies
echo "Installing Server Handler Dependencies..."
sleep 1
cd /root/server-handler/
bun install
echo "DISCORDTOKEN=" >> /root/server-handler/.env
echo "DISCORDID=" >> /root/server-handler/.env

# Installing PM2
echo "Installing PM2..."
sleep 1
bun install -g pm2
echo "alias pm2=\"bunx pm2\"" >> /root/.bashrc
source /root/.bashrc

# Setting up PM2 Profile
echo "Setting up PM2 Profile..."
sleep 1
echo -e '#!/bin/bash\n' >> /root/server-handler/start.sh
echo "cd /root/server-handler/" >> /root/server-handler/start.sh
echo "bun run src/main.ts" >> /root/server-handler/start.sh
chmod +x /root/server-handler/start.sh
pm2 start --name service /root/server-handler/start.sh
pm2 stop service
pm2 save

echo "Server Handler Install Script Complete! Please add your Discord Token and Discord ID to the .env file, and edit the lib/config.json file."
sleep 3
