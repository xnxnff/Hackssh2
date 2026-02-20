#!/bin/bash

echo "==== Linux Agent Installer ===="

# طلب البورت
read -p "Enter SSH Port: " PORT

if [[ -z "$PORT" ]]; then
  echo "Port required!"
  exit 1
fi

# إنشاء config
cat <<EOF > /usr/local/bin/config.conf
SERVER="37.237.185.27"
USER="ali"
PORT="$PORT"
REMOTE_BACKUP_DIR="/home/ali/backups"
LOCAL_IMAGE_DIR="\$HOME/Pictures"
INTERVAL=60
EOF

# نسخ الملفات
cp agent.sh /usr/local/bin/
cp backup.sh /usr/local/bin/

chmod +x /usr/local/bin/agent.sh
chmod +x /usr/local/bin/backup.sh

# نسخ الخدمات
cp linux-agent.service /etc/systemd/system/
cp linux-backup.service /etc/systemd/system/

# تشغيل
systemctl daemon-reload
systemctl enable linux-agent
systemctl enable linux-backup

systemctl start linux-agent
systemctl start linux-backup

echo "[+] Installed!"
echo "[+] SSH Port: $PORT"
