#/usr/bin/env bash -eo pipefail

cat secret | jq --raw-output '.["auth.cas"]' | base64 -d > auth.cas
cat secret | jq --raw-output '.["auth.key"]' | base64 -d > auth.key
cat secret | jq --raw-output '.["auth.crt"]' | base64 -d > auth.crt
token="$(cat secret | jq --raw-output '.slack_oauth_token')"
signkey="$(cat secret | jq --raw-output '.slack_signing_secret')"

sed -i '' -e "s/{token}/${token}/" config.toml
sed -i '' -e "s/{secret}/${signkey}/" config.toml

