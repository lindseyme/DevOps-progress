#!/bin/bash

directory="ah-frontend-zeus"
domain="ayesiga.me"
email="ayesigalindsey@gmail.com"

#@ installing the packages required @#
installPackages() {
  echo "######################## install packages ##############################"
  sudo apt-get update
  sudo apt-get install nginx -y
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
  sudo apt-get install -y nodejs
  sudo npm install yarn -g
}

#@ Cloning into the repository @#
cloneRepo() {
  echo "##################### cloning repository ###############################"
  if [ -d "$directory" ]
    then
    rm -r $directory
    git clone https://github.com/andela/ah-frontend-zeus.git
  else
    git clone https://github.com/andela/ah-frontend-zeus.git
fi
echo "API_URL=https://zeus-staging.herokuapp.com/api" > $directory/.env
}

#@ Installing the dependencies required @#
dependencies(){
  echo "#################### install dependencies ################################"
  cd $directory
  sudo yarn
}

#@ Starting the application @#
startApp() {
  bundle="/var/www/html/ayesiga"
  echo "##################### start APP ##########################################"
  sudo yarn build
  if [ -d "$bundle" ]
   then
    sudo rm -rf $bundle
    sudo mkdir $bundle
  else
    sudo mkdir $bundle
  fi
  sudo cp dist/* $bundle/.



}

nginxConfig() {
  echo "################ configuring nginx ######################################"
  sudo systemctl enable nginx
  sudo systemctl start nginx
  sudo cp /etc/nginx/sites-enabled/default /etc/nginx/conf.d/ayesiga.conf
  sudo sed -i 's/#.*$//g;/^[[:space:]]*$/d' /etc/nginx/conf.d/ayesiga.conf
  sudo sed -i 's/ default_server;/;/g' /etc/nginx/conf.d/ayesiga.conf
  sudo sed -i 's|root /var/www/html;|root /var/www/html/ayesiga;|g' /etc/nginx/conf.d/ayesiga.conf
  sudo sed -i 's|server_name _;|server_name ayesiga.me www.ayesiga.me;|g' /etc/nginx/conf.d/ayesiga.conf
  sudo nginx -t
  sudo systemctl restart nginx
}

configureSSL() {
  echo "################ SSL Certificate #######################################"
  #install SSL certificate
  sudo apt-get install software-properties-common
  sudo add-apt-repository universe
  sudo add-apt-repository ppa:certbot/certbot -y
  sudo apt-get update
  sudo apt-get install certbot python-certbot-nginx -y
  # configure nginx proxy file to use SSL Certificate
  sudo certbot --nginx -d $domain -d www.$domain -n --agree-tos -m $email --redirect --expand
}

deploy() {
  installPackages
  cloneRepo
  dependencies
  startApp
  nginxConfig
  configureSSL
} 

deploy