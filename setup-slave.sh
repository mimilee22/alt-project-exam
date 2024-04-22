#!/bin/bash

# Update package lists without prompting
sudo apt update -y

# Install Apache, MySQL, PHP, Git without prompting
sudo DEBIAN_FRONTEND=noninteractive apt install -y apache2 mysql-server php php-mysql git

# Clone PHP application from GitHub
git clone https://github.com/example/php-application.git /var/www/html/php-application

# Configure Apache virtual host
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/php-application.conf
sudo sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/php-application/g' /etc/apache2/sites-available/php-application.conf
sudo a2ensite php-application.conf
sudo systemctl reload apache2

# Secure MySQL installation (optional, non-interactive)
echo "mysql-server mysql-server/root_password password your_root_password" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password your_root_password" | sudo debconf-set-selections
sudo mysql_secure_installation <<< "your_root_password
n
n
n
n
"

# Restart Apache and MySQL services
sudo systemctl restart apache2
sudo systemctl restart mysql
