#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 150s;

echo 'y' | docker-compose exec -T pleroma ./cli.sh user new admin ${ADMIN_EMAIL} --admin --password ${ADMIN_PASSWORD}