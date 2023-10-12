#set env vars
set -o allexport; source .env; set +o allexport;

cat <<EOT > ./servers.json
{
    "Servers": {
        "1": {
            "Name": "local",
            "Group": "Servers",
            "Host": "172.17.0.1",
            "Port": 57249,
            "MaintenanceDB": "postgres",
            "SSLMode": "prefer",
            "Username": "postgres",
            "PassFile": "/pgpass"
        }
    }
}
EOT


cat /opt/elestio/startPostfix.sh > post.txt
filename="./post.txt"

SMTP_LOGIN=""
SMTP_PASSWORD=""

while IFS= read -r line; do
  values=$(echo "$line" | grep -o '\-e [^ ]*' | sed 's/-e //')

  while IFS= read -r value; do
    if [[ $value == RELAYHOST_USERNAME=* ]]; then
      SMTP_LOGIN=${value#*=}
    elif [[ $value == RELAYHOST_PASSWORD=* ]]; then
      SMTP_PASSWORD=${value#*=}
    fi
  done <<< "$values"

done < "$filename"

cat <<EOT > ./config.exs

import Config

config :pleroma, :instance,
  registrations_open: true,
  invites_enabled: true,
  federating: true,
  allow_relay: true

config :pleroma, Pleroma.Emails.Mailer,
  enabled: true,
  adapter: Swoosh.Adapters.SMTP,
  relay: "tuesday.mxrouting.net",
  username: "${SMTP_LOGIN}",
  password: "${SMTP_PASSWORD}",
  port: 25,
  ssl: false,
  auth: :always

config :pleroma, configurable_from_database: true

EOT

rm post.txt