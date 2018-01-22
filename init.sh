#!/bin/sh

# Set up Magento using CLI
./bin/magento setup:install --base-url=http://localhost:8080/ \
 --db-host=mysql --db-name=magento --db-user=magento --db-password=[mysql_password] \
 --admin-firstname=Magento --admin-lastname=User --admin-email=user@example.com \
 --admin-user=admin --admin-password=admin123 --language=en_US \
 --currency=USD --timezone=Asia/Jakarta --use-rewrites=1

# Enable developer mode
./bin/magento deploy:mode:set developer
