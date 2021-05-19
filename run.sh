#!/usr/bin/env bash

# Load .env file
source .env

# USAGE:
# $0 email password path-to-pub-key

# Must have ADB 1.0.41 and scrcpy installed
# Also requires npm, curl for login

# Login

# TODO: Verify successful login
ACCESS_TOKEN=$(node index.js $1 $2)

# TODO: Get actual screen size
SCREEN_X=1920
SCREEN_Y=1080

EXTRA_BODY=""
if [[ "$4" == "--force-new" ]]; then
	EXTRA_BODY=', "force_new": "true"'
fi

PUB_KEY=$(cat $3)
BODY="{\"pub_key\": \"$PUB_KEY\", \"screen\":{\"res_x\": $SCREEN_X, \"res_y\": $SCREEN_Y}$EXTRA_BODY}"

RESPONSE=$(curl $REMOTE_IP -H "Content-Type: application/json" -H "Authorization: Bearer $ACCESS_TOKEN" -d "$BODY")

#TODO: Verify director returned 200

RESPONSE_BODY=$(echo $RESPONSE | jq .body | sed 's/\\//g')
RESPONSE_BODY=$(echo $RESPONSE_BODY | sed 's/^.\(.*\).$/\1/')

CONTAINER_IP=$(echo $RESPONSE_BODY | jq .ip)
CONTAINER_IP=$(echo $CONTAINER_IP | sed 's/^.\(.*\).$/\1/')
CONTAINER_PORT=$(echo $RESPONSE_BODY | jq .port)


echo Connecting to: $CONTAINER_IP:$CONTAINER_PORT

sleep 90

ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[$CONTAINER_IP]:$CONTAINER_PORT"

adb kill-server
( ( ssh  -o "StrictHostKeyChecking no" root@$CONTAINER_IP -L 5037:localhost:5037 -R 27183:localhost:27183 -L 4000:localhost:4000 -L 4001:localhost:554 -p $CONTAINER_PORT & echo $! >&3 ) 3>pid | scrcpy ) || ( kill $(<pid) && sleep 30 && ( ssh  -o "StrictHostKeyChecking no" root@$CONTAINER_IP -L 5037:localhost:5037 -R 27183:localhost:27183 -L 4000:localhost:4000 -L 4001:localhost:554 -p $CONTAINER_PORT & echo $! >&3 ) 3>pid | scrcpy )
kill $(<pid)
rm pid
