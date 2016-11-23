#!/usr/bin/env bash

# drainage setup script

# Make sure this script is being run by root
if [[ $EUID -ne 0 ]]; then
   echo "You must be root to install drainage_pi" 1>&2
   echo "Try: sudo "$0 1>&2
   exit 1
fi

echo -e "\nDrainage Installer\n----------------->"

echo -e "\nInstalling the prerequisites...."
apt-get -y install ethtool wireless-tools msmtp apache2 php5 libapache2-mod-php5 pwauth git || { echo -e "Install failed!" 1>&2; exit 1; }

echo -e "\nRetrieving latest copy of drainage_pi from GitHub...."
git clone https://github.com/Qalexcitysocial.git /var/www/html/

echo -e "\nGranting the webserver access to the email configuration...."
chmod 640 /etc/msmtprc || { echo -e "Install failed!" 1>&2; exit 1; }
chgrp www-data /etc/msmtprc || { echo -e "Install failed!" 1>&2; exit 1; }

echo -e "\nGranting the webserver access to the GPIO...."
addgroup gpio &> /dev/null
adduser www-data gpio || { echo -e "Install failed!" 1>&2; exit 1; }

echo -e "\nEnabling the required Apache modules...."
a2enmod rewrite authnz_external || { echo -e "Install failed!" 1>&2; exit 1; }

echo -e "\nRestarting Apache...."
service apache2 restart || { echo -e "Install failed!" 1>&2; exit 1; }

echo -e "\n\nConfiguring email settings\n--------------------------\n"
defaultMailTo="pi@localhost"
defaultMailFrom="pi@localhost"
emailConfigured="N";
until [[ "$emailConfigured" =~ ^[yY]$ ]]; do
  read -p "Email address messages should be sent to [$defaultMailTo]: " mailTo
  read -p "Email address messages should be sent from [$defaultMailFrom]: " mailFrom
  if [[ -z "$mailTo" ]]; then
    mailTo="$defaultMailTo"; else
    defaultMailTo="$mailTo"
  fi
  if [[ -z "$mailFrom" ]]; then
    mailFrom="$defaultMailFrom"; else
    defaultMailFrom="$mailFrom"
  fi
  echo -e "\nMail To:   $mailTo\nMail From: $mailFrom\n"
  emailConfigured="X"
  until [[ "$emailConfigured" =~ ^[yYnN]$ || -z "$emailConfigured" ]]; do
    read -p "Is this correct? [y/N]: " -n1 emailConfigured
    echo
  done
done

echo -e "\nInstall successful!"
echo -e "Finish the configuration as described in /var/www/html/drainage/README.md"
echo -e "...and you're ready to go!\n"