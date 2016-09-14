cat<<EOF > reboot_if_needed.sh 
#!/bin/bash -e

if [ -f /var/run/reboot-required ]; then
        /bin/cat /var/run/reboot-required
        /bin/cat /var/run/reboot-required.pkgs
        /sbin/reboot
fi
EOF

( crontab -l ; echo "0 0 * * * /bin/bash /root/reboot_if_needed.sh" ) | crontab -
