#!/bin/bash

echo "==============================="
echo "   Linux Backup Agent Setup"
echo "==============================="

# طلب البورت
read -p "Enter SSH Port to use (example 2222): " PORT

# تحقق من الإدخال
if [[ -z "$PORT" ]]; then
  echo "[!] Port cannot be empty!"
  exit 1
fi

echo "[+] Using port: $PORT"

# إنشاء config مؤقت
cat <<EOF > /usr/local/bin/config.conf
SERVER="37.237.185.27"
USER="ali"
PORT="$PORT"
REMOTE_BACKUP_DIR="/home/ali/backups"
LOCAL_IMAGE_DIR="\$HOME/Pictures"
INTERVAL=60
EOF

# نسخ السكربتات
cp agent.sh /usr/local/bin/agent.sh
cp backup.sh /usr/local/bin/backup.sh

chmod +x /usr/local/bin/agent.sh
chmod +x /usr/local/bin/backup.sh

# نسخ الخدمات
cp linux-agent.service /etc/systemd/system/
cp linux-backup.service /etc/systemd/system/

# إعادة تحميل
systemctl daemon-reexec
systemctl daemon-reload

# تفعيل
systemctl enable linux-agent
systemctl enable linux-backup

systemctl start linux-agent
systemctl start linux-backup

echo "[+] Installed successfully!"
echo "[+] Your SSH Port is: $PORT"
