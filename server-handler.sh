#!/bin/bash

# Updating and Upgrading
apt update
apt upgrade -y

# Installing Requirements
apt install curl wget unzip git libcurl4 -y

# Installing Bun
curl -fsSL https://bun.com/install | bash
source /root/.bashrc

# Installing Server Handler
git clone https://github.com/Executive-Hosting/server-handler.git /root/server-handler/

# Installing Server Handler Dependencies
cd /root/server-handler/
bun install
echo "DISCORDTOKEN=" >> /root/server-handler/.env
echo "DISCORDID=" >> /root/server-handler/.env

# Installing PM2
bun install -g pm2
echo "alias pm2=\"bunx pm2\"" >> /root/.bashrc
source /root/.bashrc

# Setting up PM2 Profile
echo -e '#!/bin/bash\n' >> /root/server-handler/start.sh
echo "cd /root/server-handler/" >> /root/server-handler/start.sh
echo "bun run src/main.ts" >> /root/server-handler/start.sh
chmod +x /root/server-handler/start.sh


# Final Message
echo "Done."
