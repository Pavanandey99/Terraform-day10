#!/bin/bash
#Update and install Apache (httpd)
 sudo yum update -y
 sudo yum install httpd -y

# # Create a custom index.html with your message
 echo "<h1>Welcome from Terraform - by Pavan</h1>" | sudo tee /var/www/html/index.html
#
# # Start Apache server
 sudo systemctl start httpd
#
# # Enable Apache to start on boot
 sudo systemctl enable httpd
#
