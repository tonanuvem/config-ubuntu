#!/bin/bash
# https://tecadmin.net/setup-selenium-chromedriver-on-ubuntu/
# chrome
sudo apt-get update
sudo apt-get install -y unzip xvfb libxi6 libgconf-2-4
sudo su
sudo curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
sudo touch /etc/apt/sources.list.d/google-chrome.list
echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee -a /etc/apt/sources.list.d/google-chrome.list
sudo apt-get -y update
sudo apt-get -y install google-chrome-stable
# chromedriver
wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
sudo mv chromedriver /usr/bin/chromedriver
sudo chown root:root /usr/bin/chromedriver
sudo chmod +x /usr/bin/chromedriver
