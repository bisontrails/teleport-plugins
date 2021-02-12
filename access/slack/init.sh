#/usr/bin/env bash -eo pipefail

cp /var/config/teleport-slack.toml /etc/teleport-slack.toml

cat /tmp/secret | jq --raw-output '.["auth.cas"]' | base64 -d > /var/telebot/auth.cas
cat /tmp/secret | jq --raw-output '.["auth.key"]' | base64 -d > /var/telebot/auth.key
cat /tmp/secret | jq --raw-output '.["auth.crt"]' | base64 -d > /var/telebot/auth.crt
token="$(cat /tmp/secret | jq --raw-output '.slack_oauth_token')"
signkey="$(cat /tmp/secret | jq --raw-output '.slack_signing_secret')"

sed -i "s/{token}/${token}/" /etc/teleport-slack.toml
sed -i "s/{secret}/${signkey}/" /etc/teleport-slack.toml

teleport-slack start
