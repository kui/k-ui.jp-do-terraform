#!/bin/bash
set -eux

apt-get install -y heirloom-mailx

dir="$(dirname $0)"
user="$(cat "$dir/gmail-user")"
passwd="$(cat "$dir/gmail-password")"

cat <<EOF >> /etc/nail.rc

# added by terraform init script
set smtp-use-starttls
set smtp=smtp://smtp.gmail.com:587
set smtp-auth=login
set smtp-auth-user=$user
set smtp-auth-password=$passwd
set from="k-ui.jp<noreply@k-ui.jp>"
EOF

cp "$dir/gmail-user" /etc/
