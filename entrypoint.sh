#!/usr/bin/env bash
PA_PATH=/opt/pa

echo "Running papatcher:"
papatcher \
	--stream stable \
	--update-only \
	--dir "$PA_PATH/server" \
	--cachedir "$PA_PATH/cache" \
	--username "$PA_USERNAME" \
	--password "$PA_PASSWORD"

exec "$PA_PATH/server/stable/server" \
	--headless \
	--allow-lan \
	--mt-enabled \
	--enable-crash-reporting \
	--game-mode PAExpansion1:config \
	--replay-filename UTCTIMESTAMP \
	--output-dir "$PA_PATH/replay" \
	--replay-timeout 180 \
	--gameover-timeout 600 \
	--empty-timeout 3600 \
	--server-name "SweetFA" \
	--server-password "$SERVER_PASSWORD" \
	--max-players 8 \
	--max-spectators 2 \
	--port 20545
