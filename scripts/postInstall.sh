#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 250s;

echo 'y' | docker-compose exec -T pleroma  /opt/pleroma/bin/pleroma_ctl user new root ${ADMIN_EMAIL} --admin --password ${ADMIN_PASSWORD}