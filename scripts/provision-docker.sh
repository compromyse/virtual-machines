useradd -rm -d /home/compromyse -s /bin/bash -G sudo compromyse
groupadd -g 1000 compromyse && useradd -u 1000 -g compromyse -G sudo -m -s /bin/bash compromyse
sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g'
sed -i /etc/sudoers -re 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g'
sed -i /etc/sudoers -re 's/^#includedir.*/## **Removed the include directive** ##"/g'
echo "compromyse ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "compromyse user:";  su - compromyse -c id
