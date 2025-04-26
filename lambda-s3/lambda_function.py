#!/bin/bash
# Update and install Apache (httpd)
sudo yum update -y
sudo yum install httpd -y

# Create a custom index.html with your message
echo "Welcome from Terraform uploaded to S3 then Lambda - by Pavan" | sudo tee /var/www/html/index.html

# Start Apache server
sudo systemctl start httpd

# Enable Apache to start on boot
sudo systemctl enable httpd
