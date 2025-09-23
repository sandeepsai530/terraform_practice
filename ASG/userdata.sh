#!/bin/bash
#sudo apt update -y
#sudo apt install -y nginx
#sudo systemctl start nginx
#sudo systemctl enable nginx
#echo "<h1>This message from yt webserver : $(hostname -i)</h1>" > /var/www/html/index.html
#echo "<h1>This message from GREEN webserver</h1>" > /var/www/html/index.html

#!/bin/bash
# Update system
apt update -y

# Install Nginx
apt install -y nginx

# Ensure Nginx starts
systemctl enable nginx
systemctl restart nginx

# Replace default index page
echo "<h1>This message from GREEN webserver on $(hostname -i)</h1>" > /var/www/html/index.html
