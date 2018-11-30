#!/bin/sh

### BEGIN INIT INFO
# Provides:          snort-alerte
# Required-Start:    $network
# Required-Stop:     $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: snort-alerte
# Description: alerte intrusion snort
### END INIT INFO

# Variables de configuration

EMAILSNORT='snort@snort.com'
VOTREMAIL='votremail@mail.com'
OBJET='Alerte Intrusion'
MESSAGE='Attention une intrusion a été détectée !'

# Récupération du smtp local

SMTP=$(curl -s http://check414.free.fr/index.php/mon-smtp/ | sed -n -r 's%<b>(.*)<\/b>%\1%p' | cut -d":" -f2 | cut -d"<" -f1)

# Verification des logs & envoie alerte mail

if [ -e /var/log/snort/snort.log.* ] ; then
  sendemail -f $EMAILSNORT -t $VOTREMAIL -u $OBJET -m "$MESSAGE" -s $SMTP
fi
